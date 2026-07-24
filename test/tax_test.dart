import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/core/money/currency.dart';
import 'package:sole_ledger/core/money/money.dart';
import 'package:sole_ledger/domain/tax/expense_categories.dart';
import 'package:sole_ledger/domain/tax/invoice_totals.dart';
import 'package:sole_ledger/domain/tax/jp_income_tax.dart';
import 'package:sole_ledger/domain/tax/period_report.dart';
import 'package:sole_ledger/domain/tax/vat_treatment.dart';

void main() {
  group('Money', () {
    test('fromMajor converts to minor units with correct precision', () {
      expect(Money.fromMajor(123.45, Currency.eur).minorUnits, 12345);
      expect(Money.fromMajor(1000, Currency.jpy).minorUnits, 1000);
    });

    test('does not accumulate floating point error', () {
      final a = Money.fromMajor(0.1, Currency.eur);
      final b = Money.fromMajor(0.2, Currency.eur);
      expect((a + b).minorUnits, 30); // exactly €0.30
    });

    test('rejects mixing currencies', () {
      expect(
        () => Money(100, Currency.eur) + Money(100, Currency.jpy),
        throwsArgumentError,
      );
    });
  });

  group('InvoiceCalculator', () {
    test('reverse-charge invoice has zero tax and prints the statement', () {
      final totals = InvoiceCalculator.compute([
        TaxableLine(net: Money.fromMajor(1000, Currency.eur), treatment: VatTreatment.reverseChargeEu),
        TaxableLine(net: Money.fromMajor(500, Currency.eur), treatment: VatTreatment.reverseChargeEu),
      ], Currency.eur);

      expect(totals.net.minorUnits, 150000);
      expect(totals.taxTotal.isZero, isTrue);
      expect(totals.gross.minorUnits, 150000);
      expect(totals.printsReverseChargeStatement, isTrue);
    });

    test('Dutch 21% VAT is rounded once per rate group', () {
      final totals = InvoiceCalculator.compute([
        TaxableLine(net: Money.fromMajor(100, Currency.eur), treatment: VatTreatment.standardNl21),
        TaxableLine(net: Money.fromMajor(33.33, Currency.eur), treatment: VatTreatment.standardNl21),
      ], Currency.eur);

      // net = 133.33 -> tax = 133.33 * 0.21 = 27.9993 -> 28.00
      expect(totals.net.minorUnits, 13333);
      expect(totals.taxTotal.minorUnits, 2800);
      expect(totals.gross.minorUnits, 16133);
    });

    test('mixed treatments produce separate tax groups', () {
      final totals = InvoiceCalculator.compute([
        TaxableLine(net: Money.fromMajor(1000, Currency.eur), treatment: VatTreatment.reverseChargeEu),
        TaxableLine(net: Money.fromMajor(200, Currency.eur), treatment: VatTreatment.standardNl21),
      ], Currency.eur);

      expect(totals.taxGroups.length, 2);
      expect(totals.taxTotal.minorUnits, 4200); // only the NL line is taxed
    });
  });

  group('JpIncomeTaxEstimator', () {
    test('applies correct bracket, surtax and residents tax at ¥5,000,000', () {
      final e = JpIncomeTaxEstimator.estimate(5000000);
      expect(e.appliedRatePercent, 20);
      expect(e.nationalTax, 572500); // 5,000,000*0.20 - 427,500
      expect(e.reconstructionSurtax, 12022); // floor(572500 * 0.021)
      expect(e.residentsTaxApprox, 505000); // 500,000 + 5,000 per-capita
    });

    test('zero or negative income yields no tax', () {
      expect(JpIncomeTaxEstimator.estimate(0).totalEstimate, 0);
      expect(JpIncomeTaxEstimator.estimate(-100000).totalEstimate, 0);
    });
  });

  group('VatReport', () {
    test('groups by currency and treatment, computes tax per bucket', () {
      final report = VatReport.fromLines([
        ReportLine(net: Money.fromMajor(1000, Currency.eur), treatment: VatTreatment.reverseChargeEu),
        ReportLine(net: Money.fromMajor(500, Currency.eur), treatment: VatTreatment.reverseChargeEu),
        ReportLine(net: Money.fromMajor(200, Currency.eur), treatment: VatTreatment.standardNl21),
        ReportLine(net: Money.fromMajor(300000, Currency.jpy), treatment: VatTreatment.standardJp10),
      ]);

      expect(report.currencies.toSet(), {Currency.eur, Currency.jpy});
      expect(report.netTotal(Currency.eur).minorUnits, 170000); // 1500 + 200
      expect(report.taxTotal(Currency.eur).minorUnits, 4200); // only NL 21% of 200
      expect(report.taxTotal(Currency.jpy).minorUnits, 30000); // 10% of 300,000
    });
  });

  group('IncomeReport', () {
    test('net is revenue minus deductible expenses per currency', () {
      final report = IncomeReport(
        revenue: {Currency.eur: 5000000, Currency.jpy: 200000},
        expenses: {Currency.eur: 1500000, Currency.jpy: 50000},
      );
      expect(report.netOf(Currency.eur).minorUnits, 3500000);
      expect(report.netOf(Currency.jpy).minorUnits, 150000);
    });
  });

  group('Expense deductibility helpers', () {
    test('home-use apportionment reduces the deductible amount', () {
      // ¥100,000 rent at 30% business use -> ¥30,000 deductible.
      expect(
        deductibleMinorOf(deductible: true, amountMinor: 100000, businessUsePercent: 30),
        30000,
      );
    });

    test('non-deductible expense contributes nothing', () {
      expect(
        deductibleMinorOf(deductible: false, amountMinor: 100000, businessUsePercent: 100),
        0,
      );
    });

    test('VAT embedded in a gross amount is extracted correctly', () {
      // ¥11,000 gross at 10% -> ¥1,000 consumption tax.
      expect(Money(11000, Currency.jpy).vatPortionFromGross(10).minorUnits, 1000);
      // €121.00 gross at 21% -> €21.00 BTW.
      expect(Money(12100, Currency.eur).vatPortionFromGross(21).minorUnits, 2100);
    });

    test('categories expose a JP account heading and default apportionment', () {
      final rent = expenseCategoryByCode('rent');
      expect(rent.account, '地代家賃');
      expect(rent.defaultBusinessUsePercent, 30);
      expect(rent.suggestsProration, isTrue);
    });
  });
}
