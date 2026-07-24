import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/domain/tax/depreciation.dart';

void main() {
  int gross(int cost, DateTime acq, DepreciationMethod m, int life, int year) =>
      Depreciation.grossForYear(
        costMinor: cost,
        acquisition: acq,
        method: m,
        usefulLifeYears: life,
        year: year,
      );

  group('fullExpense (少額特例)', () {
    final acq = DateTime(2026, 5, 1);
    test('deducts the whole cost in the acquisition year only', () {
      expect(gross(300000, acq, DepreciationMethod.fullExpense, 4, 2026), 300000);
      expect(gross(300000, acq, DepreciationMethod.fullExpense, 4, 2027), 0);
    });
  });

  group('lumpThreeYear (一括償却)', () {
    final acq = DateTime(2026, 5, 1);
    test('spreads evenly over three years and sums to cost', () {
      final y1 = gross(180000, acq, DepreciationMethod.lumpThreeYear, 4, 2026);
      final y2 = gross(180000, acq, DepreciationMethod.lumpThreeYear, 4, 2027);
      final y3 = gross(180000, acq, DepreciationMethod.lumpThreeYear, 4, 2028);
      expect([y1, y2, y3], [60000, 60000, 60000]);
      expect(y1 + y2 + y3, 180000);
      expect(gross(180000, acq, DepreciationMethod.lumpThreeYear, 4, 2029), 0);
    });

    test('puts the rounding remainder in the final year', () {
      final total = [2026, 2027, 2028]
          .map((y) => gross(100000, acq, DepreciationMethod.lumpThreeYear, 4, y))
          .fold(0, (s, v) => s + v);
      expect(total, 100000);
    });
  });

  group('straightLine (定額法)', () {
    // ¥400,000 laptop, 4-year life, acquired July → 6 months in year 1.
    final acq = DateTime(2026, 7, 1);
    const cost = 400000;
    const m = DepreciationMethod.straightLine;

    test('prorates the first year by months in service', () {
      expect(gross(cost, acq, m, 4, 2026), 50000); // 100000 * 6/12
    });
    test('full annual amount in middle years', () {
      expect(gross(cost, acq, m, 4, 2027), 100000);
      expect(gross(cost, acq, m, 4, 2028), 100000);
    });
    test('leaves a ¥1 memo value once fully depreciated', () {
      final total = [for (var y = 2026; y <= 2032; y++) gross(cost, acq, m, 4, y)]
          .fold(0, (s, v) => s + v);
      expect(total, cost - 1);
      expect(
        Depreciation.bookValueAtEndOf(
            costMinor: cost,
            acquisition: acq,
            method: m,
            usefulLifeYears: 4,
            year: 2032),
        1,
      );
    });
    test('applies business-use percentage to the deductible slice', () {
      final deductible = Depreciation.deductibleForYear(
        costMinor: cost,
        acquisition: acq,
        method: m,
        usefulLifeYears: 4,
        businessUsePercent: 50,
        year: 2027,
      );
      expect(deductible, 50000); // 100000 * 50%
    });
  });
}
