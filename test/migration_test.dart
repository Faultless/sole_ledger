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

  for (final from in [7, 8]) {
    test('a v$from ledger opens on v9 with its invoices intact', () async {
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

  test('a v9 ledger reopens unchanged', () async {
    await seedAtVersion(9);
    final db = AppDatabase(NativeDatabase(file));
    final invoice = await AppRepository(db).findInvoice('invoice-1');
    expect(invoice!.dueDateEnabled, isTrue);
    await db.close();
  });
}
