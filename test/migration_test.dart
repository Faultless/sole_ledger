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

  for (final from in [7, 8, 9]) {
    test('a v$from ledger opens on v10 with its invoices intact', () async {
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

  test('a v10 ledger reopens unchanged', () async {
    await seedAtVersion(10);
    final db = AppDatabase(NativeDatabase(file));
    final invoice = await AppRepository(db).findInvoice('invoice-1');
    expect(invoice!.dueDateEnabled, isTrue);
    expect(invoice.allowanceMinor, 0);
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
