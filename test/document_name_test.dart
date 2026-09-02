import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/core/format/document_name.dart';
import 'package:sole_ledger/domain/enums.dart';
import 'package:sole_ledger/domain/tax/report_period.dart';

void main() {
  group('invoice', () {
    test('names the document, both parties and the month', () {
      expect(
        DocumentName.invoice(
          number: 'INV-2026-0001',
          issuer: 'Frontendienst',
          client: 'DeliHome',
          issueDate: DateTime(2026, 8, 14),
        ),
        'INV-2026-0001_Frontendienst_DeliHome_Aug_2026',
      );
    });

    test('drops a trailing legal suffix and runs words together', () {
      expect(
        DocumentName.invoice(
          number: 'INV-2026-0001',
          issuer: 'Frontendienst',
          client: 'Deli Home Netherlands B.V.',
          issueDate: DateTime(2026, 8, 14),
        ),
        'INV-2026-0001_Frontendienst_DeliHomeNetherlands_Aug_2026',
      );
    });

    test('keeps the number readable but strips unsafe characters', () {
      expect(
        DocumentName.invoice(
          number: 'INV/2026 0001',
          issuer: 'X',
          client: 'Y',
          issueDate: DateTime(2026, 1, 2),
        ),
        startsWith('INV20260001_'),
      );
    });
  });

  group('party names', () {
    String clientPart(String name) => DocumentName.invoice(
          number: 'N',
          issuer: 'I',
          client: name,
          issueDate: DateTime(2026, 3, 1),
        ).split('_')[2];

    test('folds accents to ASCII', () {
      expect(clientPart('Café Zürich'), 'CafeZurich');
      expect(clientPart('Ærø Ångström'), 'AeroAngstrom');
    });

    test('drops assorted legal forms', () {
      expect(clientPart('Acme B.V.'), 'Acme');
      expect(clientPart('Acme GmbH'), 'Acme');
      expect(clientPart('Acme, Inc.'), 'Acme');
      expect(clientPart('アクメ 株式会社'), 'アクメ');
    });

    test('keeps a suffix-like word that is the whole name', () {
      expect(clientPart('BV'), 'BV');
    });

    test('respects casing the user chose for a short name', () {
      expect(clientPart('DeliHome'), 'DeliHome');
      expect(clientPart('deli home'), 'DeliHome');
    });

    test('keeps non-Latin scripts rather than emptying the name', () {
      expect(clientPart('株式会社テスト'), '株式会社テスト');
    });

    test('caps an unreasonably long name', () {
      final part = clientPart('A' * 80);
      expect(part.length, DocumentName.maxPartLength);
    });

    test('an empty party leaves no stray separator', () {
      final name = DocumentName.invoice(
        number: 'INV-1',
        issuer: 'Frontendienst',
        client: '',
        issueDate: DateTime(2026, 8, 1),
      );
      expect(name, 'INV-1_Frontendienst_Aug_2026');
      expect(name, isNot(contains('__')));
    });
  });

  group('reports', () {
    test('a monthly timesheet is named for its month', () {
      expect(
        DocumentName.timesheet(
          issuer: 'Frontendienst',
          period: ReportPeriod.ofMonth(2026, 8),
        ),
        'Timesheet_Frontendienst_Aug_2026',
      );
    });

    test('a quarterly timesheet is named for its quarter', () {
      expect(
        DocumentName.timesheet(
          issuer: 'Frontendienst',
          period: ReportPeriod.ofQuarter(2026, Quarter.q3),
        ),
        'Timesheet_Frontendienst_Q3_2026',
      );
    });

    test('vat and income', () {
      expect(
        DocumentName.vatReturn(
            issuer: 'Frontendienst', year: 2026, quarter: Quarter.q3),
        'VAT_Frontendienst_Q3_2026',
      );
      expect(
        DocumentName.annualIncome(issuer: 'Frontendienst', year: 2026),
        'Income_Frontendienst_2026',
      );
    });

    test('a month and its quarter never collide', () {
      final month = DocumentName.timesheet(
          issuer: 'F', period: ReportPeriod.ofMonth(2026, 7));
      final quarter = DocumentName.timesheet(
          issuer: 'F', period: ReportPeriod.ofQuarter(2026, Quarter.q3));
      expect(month, isNot(quarter));
    });
  });

  test('every month abbreviates to three ASCII letters', () {
    for (var m = 1; m <= 12; m++) {
      final abbr = DocumentName.monthAbbreviation(m);
      expect(abbr, hasLength(3));
      expect(abbr, matches(RegExp(r'^[A-Z][a-z]{2}$')));
    }
  });
}
