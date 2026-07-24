import 'jp_income_tax.dart';

/// Turns a year-to-date business profit (already converted to yen) into a
/// "set aside for tax" figure, using [JpIncomeTaxEstimator].
///
/// This is a *planning provision*, not a filing: it applies the estimator to
/// profit directly (no personal deductions like the blue-return or basic
/// deduction, nor social-insurance deductions), which deliberately errs on the
/// high side so you reserve enough. The real liability settles at 確定申告.
class TaxProvision {
  const TaxProvision({required this.profitJpy, required this.estimate});

  /// YTD profit (revenue − deductible expenses) converted to whole yen.
  final int profitJpy;
  final JpIncomeTaxEstimate estimate;

  factory TaxProvision.fromProfitJpy(int profitJpy) {
    final base = profitJpy < 0 ? 0 : profitJpy;
    return TaxProvision(
      profitJpy: profitJpy,
      estimate: JpIncomeTaxEstimator.estimate(base),
    );
  }

  /// Total to reserve (national + surtax + residents' tax), in yen.
  int get setAsideJpy => estimate.totalEstimate;

  /// Share of profit that goes to Japanese tax, 0..1. Zero when there's no
  /// (positive) profit yet.
  double get effectiveRate =>
      profitJpy <= 0 ? 0 : setAsideJpy / profitJpy;

  /// What's left after the provision, in yen (can be negative if at a loss).
  int get takeHomeJpy => profitJpy - setAsideJpy;

  /// Applies the effective rate to a billed hourly rate to show the rough
  /// take-home per hour (before per-hour expenses), in the rate's own units.
  double takeHomePerHour(double billedRate) =>
      billedRate * (1 - effectiveRate);
}
