import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sole_ledger/data/db/database.dart';
import 'package:sole_ledger/data/repositories/app_repository.dart';
import 'package:sole_ledger/features/invoices/invoice_pdf.dart';

/// The A4 page is fixed-height: the pdf package throws if the column overflows,
/// so building a busy invoice end-to-end is the cheapest guard on the footer's
/// signature blocks not pushing the document off the page.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => initializeDateFormatting());

  Future<void> render({required bool dueDateEnabled, required int lineCount}) async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = AppRepository(db);
    await repo.ensureBusinessProfile();
    await db.update(db.businessProfiles).write(BusinessProfilesCompanion(
          legalName: const Value('Serge Kamel'),
          tradeName: const Value('Sole Ledger Works'),
          addressLine1: const Value('1-2-3 Nishiazabu'),
          postalCode: const Value('106-0031'),
          city: const Value('Tokyo'),
          country: const Value('Japan'),
          email: const Value('hello@example.com'),
          kvkNumber: const Value('12345678'),
          vatId: const Value('NL001234567B01'),
          bankName: const Value('Some Bank N.V.'),
          iban: const Value('NL00SOME0123456789'),
          bic: const Value('SOMENL2A'),
        ));

    final clientId = repo.newId();
    await repo.upsertClient(ClientsCompanion(
      id: Value(clientId),
      name: const Value('Acme Nederland B.V.'),
      addressLine1: const Value('Keizersgracht 100'),
      postalCode: const Value('1015 CS'),
      city: const Value('Amsterdam'),
      country: const Value('Netherlands'),
      vatId: const Value('NL009876543B01'),
    ));

    final invoiceId = repo.newId();
    await repo.createInvoice(
      invoice: InvoicesCompanion.insert(
        id: invoiceId,
        number: 'INV-2026-0001',
        clientId: clientId,
        issueDate: DateTime(2026, 8, 30),
        dueDate: DateTime(2026, 9, 29),
        dueDateEnabled: Value(dueDateEnabled),
        createdAt: DateTime(2026, 8, 30),
        notes: const Value('Thanks — payment in EUR please.'),
      ),
      lines: [
        for (var i = 0; i < lineCount; i++)
          InvoiceLinesCompanion.insert(
            id: repo.newId(),
            invoiceId: invoiceId,
            description: 'Consulting work, sprint ${i + 1}',
            unitPriceMinor: 10000,
            quantity: const Value(8),
          ),
      ],
      timeEntryIds: const [],
    );

    final invoice = (await repo.findInvoice(invoiceId))!;
    final client = (await repo.findClient(clientId))!;
    final profile = (await repo.watchBusinessProfile().first)!;
    final bytes = await InvoicePdf.build(
      profile: profile,
      client: client,
      invoice: invoice,
      lines: await repo.invoiceLines(invoiceId),
    );
    expect(bytes.lengthInBytes, greaterThan(1000));
    await db.close();
  }

  test('renders with a due date', () => render(dueDateEnabled: true, lineCount: 6));
  test('renders without a due date', () => render(dueDateEnabled: false, lineCount: 6));
  test('renders a busy invoice', () => render(dueDateEnabled: true, lineCount: 14));
}
