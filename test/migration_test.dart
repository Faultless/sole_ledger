import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sole_ledger/data/db/database.dart';
import 'package:sole_ledger/data/repositories/app_repository.dart';

/// Upgrading the app must never cost the user data: every ledger already on
/// disk was written by an older schema. These tests build a database, wind it
/// back to how an older release would have left it, then reopen it through the
/// real migration path and check the records — and their meaning — survive.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory dir;
  late File file;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('sole_ledger_migration');
    file = File(p.join(dir.path, 'ledger.sqlite'));
  });
  tearDown(() => dir.deleteSync(recursive: true));

  /// Seeds a ledger, then strips the columns added after [version] and stamps
  /// the file with that version — the state an older release would leave.
  Future<void> seedAtVersion(int version) async {
    final db = AppDatabase(NativeDatabase(file));
    final repo = AppRepository(db);
    await repo.ensureBusinessProfile();

    const clientId = 'client-1';
    await repo.upsertClient(const ClientsCompanion(
      id: Value(clientId),
      name: Value('Acme Nederland B.V.'),
      paymentTermDays: Value(14),
    ));
    await repo.createInvoice(
      invoice: InvoicesCompanion.insert(
        id: 'invoice-1',
        number: 'INV-2025-0007',
        clientId: clientId,
        issueDate: DateTime(2025, 11, 3),
        dueDate: DateTime(2025, 12, 3),
        createdAt: DateTime(2025, 11, 3),
        totalMinor: const Value(150000),
      ),
      lines: [
        InvoiceLinesCompanion.insert(
          id: 'line-1',
          invoiceId: 'invoice-1',
          description: 'Consulting',
          unitPriceMinor: 15000,
          quantity: const Value(10),
        ),
      ],
      timeEntryIds: const [],
    );

    if (version < 11) {
      await db.customStatement('ALTER TABLE invoices DROP COLUMN signed');
      await db.customStatement(
          'ALTER TABLE business_profiles DROP COLUMN signature_image');
      await db.customStatement('ALTER TABLE clients DROP COLUMN short_name');
    }
    if (version < 10) {
      for (final c in [
        'allowance_enabled',
        'allowance_rate_percent',
        'allowance_mode',
        'allowance_minor',
      ]) {
        await db.customStatement('ALTER TABLE invoices DROP COLUMN $c');
      }
      for (final c in [
        'default_allowance_enabled',
        'default_allowance_rate_percent',
        'default_allowance_mode',
      ]) {
        await db.customStatement(
            'ALTER TABLE business_profiles DROP COLUMN $c');
      }
    }
    if (version < 9) {
      await db.customStatement(
          'ALTER TABLE invoices DROP COLUMN due_date_enabled');
    }
    if (version < 8) {
      await db.customStatement(
          'ALTER TABLE clients DROP COLUMN payment_due_day_of_month');
    }
    if (version < 7) {
      await db.customStatement(
          'ALTER TABLE invoice_lines DROP COLUMN from_time_entries');
    }
    await db.customStatement('PRAGMA user_version = $version');
    await db.close();
  }

  for (final from in [7, 8, 9, 10]) {
    test('a v$from ledger opens on v11 with its invoices intact', () async {
      await seedAtVersion(from);

      final db = AppDatabase(NativeDatabase(file));
      final repo = AppRepository(db);

      final invoice = await repo.findInvoice('invoice-1');
      expect(invoice, isNotNull);
      expect(invoice!.number, 'INV-2025-0007');
      expect(invoice.issueDate, DateTime(2025, 11, 3));
      expect(invoice.dueDate, DateTime(2025, 12, 3));
      expect(invoice.totalMinor, 150000);
      // The whole point of the default: an invoice written before the toggle
      // existed keeps printing its due date exactly as it always did.
      expect(invoice.dueDateEnabled, isTrue);
      // An invoice written before the allowance existed is not repriced: it
      // carries no allowance, and its stored total is the one it was issued
      // with.
      expect(invoice.allowanceEnabled, isFalse);
      expect(invoice.allowanceMinor, 0);
      expect(invoice.totalMinor, 150000);
      expect(invoice.revenueMinor, invoice.subtotalMinor);
      // An invoice issued before signing existed stays unsigned; nothing is
      // stamped onto a document already in a client's hands.
      expect(invoice.signed, isFalse);

      final lines = await repo.invoiceLines('invoice-1');
      expect(lines, hasLength(1));
      expect(lines.single.description, 'Consulting');
      expect(lines.single.unitPriceMinor, 15000);

      final client = await repo.findClient('client-1');
      expect(client!.name, 'Acme Nederland B.V.');
      expect(client.paymentTermDays, 14);
      // Unset day-of-month terms means the old net-N behaviour is untouched.
      expect(client.paymentDueDayOfMonth, isNull);

      await db.close();
    });
  }

  test('a v11 ledger reopens unchanged', () async {
    await seedAtVersion(11);
    final db = AppDatabase(NativeDatabase(file));
    final invoice = await AppRepository(db).findInvoice('invoice-1');
    expect(invoice!.dueDateEnabled, isTrue);
    expect(invoice.allowanceMinor, 0);
    expect(invoice.signed, isFalse);
    await db.close();
  });

  // The failure that shipped in 1.4.0. beforeOpen's self-heal adds the newest
  // columns on any open, whatever the version says, so a ledger can end up
  // holding columns its recorded version has never heard of. A migration that
  // blindly re-adds them throws "duplicate column", never advances the version,
  // and fails identically on every subsequent open — the app cannot start at
  // all. Opening such a ledger has to heal it instead.
  test('a ledger whose columns run ahead of its version still opens', () async {
    await seedAtVersion(11);
    // Wind only the version back, leaving every v10 and v11 column in place.
    final db = AppDatabase(NativeDatabase(file));
    await db.customStatement('PRAGMA user_version = 9');
    await db.close();

    final reopened = AppDatabase(NativeDatabase(file));
    final repo = AppRepository(reopened);

    // It opens, the data survives, and the version is brought up to date so
    // the next open is a no-op rather than another repair.
    final invoice = await repo.findInvoice('invoice-1');
    expect(invoice, isNotNull);
    expect(invoice!.number, 'INV-2025-0007');
    expect(invoice.totalMinor, 150000);
    final version =
        await reopened.customSelect('PRAGMA user_version').getSingle();
    expect(version.data['user_version'], 11);
    await reopened.close();
  });

  test('opening twice in a row is stable', () async {
    await seedAtVersion(11);
    final db = AppDatabase(NativeDatabase(file));
    await db.customStatement('PRAGMA user_version = 8');
    await db.close();

    for (var i = 0; i < 3; i++) {
      final reopened = AppDatabase(NativeDatabase(file));
      expect(await AppRepository(reopened).findInvoice('invoice-1'), isNotNull);
      await reopened.close();
    }
  });

  test('a partially migrated ledger heals whichever columns are missing',
      () async {
    await seedAtVersion(11);
    final db = AppDatabase(NativeDatabase(file));
    // Exactly the shape 1.4.0 left behind: v11 columns added, allowance
    // columns present, version stranded below both.
    await db.customStatement('ALTER TABLE invoices DROP COLUMN allowance_mode');
    await db.customStatement('PRAGMA user_version = 9');
    await db.close();

    final reopened = AppDatabase(NativeDatabase(file));
    final invoice = await AppRepository(reopened).findInvoice('invoice-1');
    expect(invoice, isNotNull);
    expect(invoice!.allowanceMode, 'surcharge');
    expect(invoice.signed, isFalse);
    await reopened.close();
  });

  test('an upgraded ledger has no signature and no short names', () async {
    await seedAtVersion(7);
    final db = AppDatabase(NativeDatabase(file));
    final repo = AppRepository(db);
    expect((await repo.ensureBusinessProfile()).signatureImage, isNull);
    // No short name means filenames fall back to the client's full name,
    // sanitised — nothing to configure before exporting.
    expect((await repo.findClient('client-1'))!.shortName, isNull);
    await db.close();
  });

  test('an upgraded ledger offers the allowance to new invoices', () async {
    await seedAtVersion(7);
    final db = AppDatabase(NativeDatabase(file));
    final profile = await AppRepository(db).ensureBusinessProfile();
    // The defaults arrive switched on: this is how tax is added here now.
    expect(profile.defaultAllowanceEnabled, isTrue);
    expect(profile.defaultAllowanceRatePercent, 25);
    expect(profile.defaultAllowanceMode, 'surcharge');
    await db.close();
  });
}
