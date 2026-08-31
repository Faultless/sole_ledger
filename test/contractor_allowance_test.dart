import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/core/money/currency.dart';
import 'package:sole_ledger/core/money/money.dart';
import 'package:sole_ledger/domain/tax/contractor_allowance.dart';
import 'package:sole_ledger/domain/tax/invoice_totals.dart';
import 'package:sole_ledger/domain/tax/vat_treatment.dart';

void main() {
  const eur = Currency.eur;
  // The worked example: 31.5 hours at €80.
  final net = Money.fromMajor(2520, eur);

  InvoiceTotals totalsWith(ContractorAllowance allowance) =>
      InvoiceCalculator.compute(
        [TaxableLine(net: net, treatment: VatTreatment.reverseChargeEu)],
        eur,
        allowance: allowance,
      );

  group('surcharge', () {
    test('adds rate x net', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: true, ratePercent: 21, mode: AllowanceMode.surcharge));
      expect(t.allowanceAmount, Money.fromMajor(529.20, eur));
      expect(t.gross, Money.fromMajor(3049.20, eur));
    });

    test('leaves less than the net once the allowance is itself taxed', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: true, ratePercent: 21, mode: AllowanceMode.surcharge));
      // Reserving 21% of what actually arrives.
      final reserve = t.gross.taxAt(0.21);
      expect(reserve, Money.fromMajor(640.33, eur));
      // You wanted to keep 2520 and keep 111.13 less than that.
      expect(t.gross - reserve, Money.fromMajor(2408.87, eur));
      expect(net - (t.gross - reserve), Money.fromMajor(111.13, eur));
      // The uplift covers only 17.4% of the invoice while tax takes 21% of it
      // — the gap that gross-up closes.
      expect(t.allowanceAmount.asMajor / t.gross.asMajor,
          closeTo(0.174, 0.001));
    });
  });

  group('gross-up', () {
    test('preserves the net after reserving the same rate', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: true, ratePercent: 21, mode: AllowanceMode.grossUp));
      expect(t.allowanceAmount, Money.fromMajor(669.87, eur));
      expect(t.gross, Money.fromMajor(3189.87, eur));
      // The whole point: reserve 21% of the total and the net survives intact.
      expect(t.gross - t.gross.taxAt(0.21), Money.fromMajor(2520, eur));
    });

    test('matches the gross-up table for other burdens', () {
      for (final (rate, expected) in [
        (20.0, 3150.00),
        (25.0, 3360.00),
        (30.0, 3600.00),
      ]) {
        final t = totalsWith(ContractorAllowance(
            enabled: true, ratePercent: rate, mode: AllowanceMode.grossUp));
        expect(t.gross, Money.fromMajor(expected, eur),
            reason: 'gross-up at $rate%');
      }
    });
  });

  group('guards', () {
    test('a disabled allowance adds nothing', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: false, ratePercent: 25, mode: AllowanceMode.grossUp));
      expect(t.allowanceAmount, Money.zero(eur));
      expect(t.gross, net);
      expect(t.hasAllowance, isFalse);
    });

    test('ContractorAllowance.none is inert', () {
      final t = totalsWith(ContractorAllowance.none);
      expect(t.gross, net);
    });

    test('a rate at or past 100% is clamped instead of exploding', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: true, ratePercent: 100, mode: AllowanceMode.grossUp));
      expect(t.allowanceAmount.minorUnits, isPositive);
      expect(t.gross.minorUnits, lessThan(1 << 40));
      expect(t.allowance.effectiveRatePercent, 99);
    });

    test('a negative rate is treated as none', () {
      final t = totalsWith(const ContractorAllowance(
          enabled: true, ratePercent: -5, mode: AllowanceMode.surcharge));
      expect(t.allowanceAmount, Money.zero(eur));
    });
  });

  group('bookkeeping', () {
    test('the allowance counts as revenue, VAT does not', () {
      final t = InvoiceCalculator.compute(
        [TaxableLine(net: net, treatment: VatTreatment.standardNl21)],
        eur,
        allowance: const ContractorAllowance(
            enabled: true, ratePercent: 25, mode: AllowanceMode.surcharge),
      );
      expect(t.taxTotal, Money.fromMajor(529.20, eur)); // 21% BTW
      expect(t.allowanceAmount, Money.fromMajor(630.00, eur)); // 25% uplift
      // Revenue is the fee plus the uplift — the VAT is the state's.
      expect(t.taxableRevenue, Money.fromMajor(3150.00, eur));
      expect(t.gross, Money.fromMajor(3679.20, eur));
    });

    test('rounds once, half-up, on an awkward net', () {
      final odd = Money.fromMajor(1000.01, eur);
      final t = InvoiceCalculator.compute(
        [TaxableLine(net: odd, treatment: VatTreatment.reverseChargeEu)],
        eur,
        allowance: const ContractorAllowance(
            enabled: true, ratePercent: 27.5, mode: AllowanceMode.grossUp),
      );
      // 100001 * 0.275/0.725 = 37931.4... -> 37931
      expect(t.allowanceAmount.minorUnits, 37931);
      expect(t.gross.minorUnits, 100001 + 37931);
    });
  });
}
