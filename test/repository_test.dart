import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sole_ledger/data/db/database.dart';
import 'package:sole_ledger/data/repositories/app_repository.dart';

void main() {
  late AppDatabase db;
  late AppRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = AppRepository(db);
  });

  tearDown(() => db.close());

  test('full flow: client -> time -> invoice links entries and computes totals',
      () async {
    await repo.ensureBusinessProfile();

    final clientId = repo.newId();
    await repo.upsertClient(ClientsCompanion(
      id: Value(clientId),
      name: const Value('Acme BV'),
      defaultCurrency: const Value('EUR'),
      defaultVatTreatment: const Value('reverseChargeEu'),
    ));

    final entryId = repo.newId();
    await repo.upsertTimeEntry(TimeEntriesCompanion(
      id: Value(entryId),
      clientId: Value(clientId),
      date: Value(DateTime(2026, 7, 10)),
      minutes: const Value(120), // 2h
    ));

    expect(await repo.watchUnbilledMinutes().first, 120);

    final unbilled = await repo.unbilledEntriesForClient(clientId);
    expect(unbilled.length, 1);

    final invoiceId = repo.newId();
    final number = await repo.nextInvoiceNumber();
    expect(number, startsWith('INV-'));

    await repo.createInvoice(
      invoice: InvoicesCompanion.insert(
        id: invoiceId,
        number: number,
        clientId: clientId,
        issueDate: DateTime(2026, 7, 15),
        dueDate: DateTime(2026, 8, 14),
        createdAt: DateTime(2026, 7, 15),
        currency: const Value('EUR'),
        subtotalMinor: const Value(20000), // €200 (2h @ €100)
        taxMinor: const Value(0),
        totalMinor: const Value(20000),
      ),
      lines: [
        InvoiceLinesCompanion.insert(
          id: repo.newId(),
          invoiceId: invoiceId,
          description: 'Professional services',
          unitPriceMinor: 10000,
          quantity: const Value(2),
          vatTreatment: const Value('reverseChargeEu'),
        ),
      ],
      timeEntryIds: [entryId],
    );

    // The time entry is now billed -> no longer unbilled.
    expect(await repo.watchUnbilledMinutes().first, 0);
    expect((await repo.unbilledEntriesForClient(clientId)).isEmpty, isTrue);

    // Invoice appears in the reporting window with its line.
    final rows = await repo.invoicesWithLinesBetween(
        DateTime(2026, 7, 1), DateTime(2026, 10, 1));
    expect(rows.length, 1);
    expect(rows.first.lines.length, 1);
    expect(rows.first.invoice.totalMinor, 20000);

    // Deleting the invoice releases the time entry back to unbilled.
    await repo.deleteInvoice(invoiceId);
    expect(await repo.watchUnbilledMinutes().first, 120);
  });

  test('receipt image blob round-trips through an expense', () async {
    final bytes = Uint8List.fromList(List<int>.generate(2048, (i) => i % 256));
    await repo.upsertExpense(ExpensesCompanion(
      id: Value(repo.newId()),
      date: Value(DateTime(2026, 3, 14)),
      amountMinor: const Value(600),
      currency: const Value('EUR'),
      receiptImage: Value(bytes),
      receiptMime: const Value('image/jpeg'),
    ));

    final stored = (await repo.watchExpenses().first).single;
    expect(stored.receiptImage, bytes);
    expect(stored.receiptMime, 'image/jpeg');

    // An expense without a receipt keeps the blob null.
    await repo.upsertExpense(ExpensesCompanion(
      id: Value(repo.newId()),
      date: Value(DateTime(2026, 3, 15)),
      amountMinor: const Value(300),
      currency: const Value('EUR'),
    ));
    final withoutReceipt = (await repo.watchExpenses().first)
        .firstWhere((e) => e.amountMinor == 300);
    expect(withoutReceipt.receiptImage, null);
  });

  test('beforeOpen self-heals a persisted DB missing later columns',
      () async {
    final dir = await Directory.systemTemp.createTemp('sole_ledger_heal');
    final file = File(p.join(dir.path, 'db.sqlite'));

    // First open creates the current schema; then simulate a stale on-device
    // database by dropping the columns later versions added.
    final db1 = AppDatabase(NativeDatabase(file));
    await db1.customSelect('SELECT 1').get(); // force open + create
    await db1.customStatement(
        'ALTER TABLE expenses DROP COLUMN business_use_percent');
    await db1.customStatement('ALTER TABLE expenses DROP COLUMN receipt_image');
    await db1.close();

    // Reopening must re-add the columns in beforeOpen, so the write succeeds.
    final db2 = AppDatabase(NativeDatabase(file));
    await db2.into(db2.expenses).insert(ExpensesCompanion.insert(
          id: 'e1',
          date: DateTime(2026, 7, 1),
          amountMinor: 11000,
          businessUsePercent: const Value(30),
          receiptImage: Value(Uint8List.fromList([1, 2, 3])),
        ));
    final rows = await db2.select(db2.expenses).get();
    expect(rows.single.businessUsePercent, 30);
    expect(rows.single.receiptImage, Uint8List.fromList([1, 2, 3]));
    await db2.close();

    await dir.delete(recursive: true);
  });
}
