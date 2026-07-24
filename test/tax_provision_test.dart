import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/domain/tax/tax_provision.dart';

void main() {
  group('TaxProvision', () {
    test('no profit → nothing to set aside, zero effective rate', () {
      final p = TaxProvision.fromProfitJpy(0);
      expect(p.setAsideJpy, 0);
      expect(p.effectiveRate, 0);
      expect(p.takeHomeJpy, 0);
    });

    test('a loss is clamped: no tax, but take-home stays negative', () {
      final p = TaxProvision.fromProfitJpy(-500000);
      expect(p.setAsideJpy, 0);
      expect(p.effectiveRate, 0);
      expect(p.takeHomeJpy, -500000);
    });

    test('positive profit yields a plausible provision and effective rate', () {
      // ~¥6M profit sits in the 20% national bracket; with residents' tax the
      // effective rate should land in a sane mid-range band.
      final p = TaxProvision.fromProfitJpy(6000000);
      expect(p.setAsideJpy, greaterThan(0));
      expect(p.setAsideJpy, lessThan(6000000));
      expect(p.effectiveRate, greaterThan(0.10));
      expect(p.effectiveRate, lessThan(0.35));
      expect(p.takeHomeJpy, 6000000 - p.setAsideJpy);
    });

    test('take-home per hour scales the billed rate by (1 - effective rate)', () {
      final p = TaxProvision.fromProfitJpy(6000000);
      final takeHome = p.takeHomePerHour(80);
      expect(takeHome, lessThan(80));
      expect(takeHome, closeTo(80 * (1 - p.effectiveRate), 0.001));
    });
  });
}
