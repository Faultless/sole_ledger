import '../../core/money/currency.dart';
import '../../core/money/money.dart';
import 'contractor_allowance.dart';
import 'vat_treatment.dart';

/// One priced line to be totalled: its net amount and the VAT treatment that
/// applies to it. (Quantity × unit price is resolved into [net] by the caller.)
class TaxableLine {
  const TaxableLine({required this.net, required this.treatment});
  final Money net;
  final VatTreatment treatment;
}

/// Net + tax subtotal for all lines sharing one [VatTreatment].
class TaxGroup {
  const TaxGroup({
    required this.treatment,
    required this.net,
    required this.tax,
  });

  final VatTreatment treatment;
  final Money net;
  final Money tax;

  Money get gross => net + tax;
}

/// The fully computed totals of an invoice.
class InvoiceTotals {
  const InvoiceTotals({
    required this.currency,
    required this.net,
    required this.taxGroups,
    required this.taxTotal,
    required this.allowance,
    required this.allowanceAmount,
    required this.gross,
  });

  final Currency currency;
  final Money net;
  final List<TaxGroup> taxGroups;
  final Money taxTotal;

  /// The contractor tax allowance applied, if any.
  final ContractorAllowance allowance;

  /// The uplift [allowance] added to the invoice. Zero when none applies.
  final Money allowanceAmount;

  /// What the client owes: net + VAT + allowance.
  final Money gross;

  bool get hasTax => !taxTotal.isZero;

  bool get hasAllowance => !allowanceAmount.isZero;

  /// Revenue for bookkeeping: the fee lines plus the allowance, which is part
  /// of the agreed fee and taxed as income like the rest of it. Excludes VAT,
  /// which is collected on the state's behalf and never yours.
  Money get taxableRevenue => net + allowanceAmount;

  /// True when any line carries a treatment that prints a reverse-charge
  /// statement (so the invoice renderer knows to show it).
  bool get printsReverseChargeStatement =>
      taxGroups.any((g) => g.treatment.printsReverseChargeStatement);
}

/// Pure totalling logic for an invoice.
///
/// Tax is rounded once per VAT-rate group (standard practice) rather than per
/// line, which keeps the printed tax consistent with the printed net subtotal
/// for each rate.
abstract final class InvoiceCalculator {
  /// [allowance] is the contractor tax uplift, computed on the line net and
  /// added on top. It is not a VAT treatment and carries no VAT of its own:
  /// no authority levies it and none of it is remitted to one.
  static InvoiceTotals compute(
    List<TaxableLine> lines,
    Currency currency, {
    ContractorAllowance allowance = ContractorAllowance.none,
  }) {
    // Preserve first-seen order of treatments for stable rendering.
    final order = <VatTreatment>[];
    final netByTreatment = <VatTreatment, int>{};

    for (final line in lines) {
      if (line.net.currency != currency) {
        throw ArgumentError(
          'Line currency ${line.net.currency.code} does not match invoice '
          'currency ${currency.code}.',
        );
      }
      if (!netByTreatment.containsKey(line.treatment)) {
        order.add(line.treatment);
      }
      netByTreatment.update(
        line.treatment,
        (v) => v + line.net.minorUnits,
        ifAbsent: () => line.net.minorUnits,
      );
    }

    final groups = <TaxGroup>[];
    for (final treatment in order) {
      final net = Money(netByTreatment[treatment]!, currency);
      final tax = net.taxAt(treatment.rateFraction);
      groups.add(TaxGroup(treatment: treatment, net: net, tax: tax));
    }

    final net = sumMoney(groups.map((g) => g.net), currency);
    final taxTotal = sumMoney(groups.map((g) => g.tax), currency);
    final allowanceAmount = allowance.amountOn(net);

    return InvoiceTotals(
      currency: currency,
      net: net,
      taxGroups: groups,
      taxTotal: taxTotal,
      allowance: allowance,
      allowanceAmount: allowanceAmount,
      gross: net + taxTotal + allowanceAmount,
    );
  }
}
