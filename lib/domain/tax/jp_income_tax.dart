/// Estimates Japanese personal income tax for a sole proprietor
/// (個人事業主) filing a blue return (青色申告).
///
/// This is an ESTIMATE for planning and for the informational figures printed
/// on reports — never a substitute for 確定申告 or advice from a 税理士.
/// It models:
///   * National income tax (所得税) — progressive brackets.
///   * Special reconstruction surtax (復興特別所得税) — 2.1% of national tax.
///   * Residents' tax (住民税) — approximated at a flat 10% of taxable income
///     plus a per-capita levy. The exact residents'-tax base differs slightly
///     from the national base, so this line is deliberately labelled approximate.
///
/// All amounts are whole yen (JPY has no minor unit).
class JpIncomeTaxBracket {
  const JpIncomeTaxBracket(this.upperBound, this.rate, this.deduction);

  /// Inclusive upper bound of taxable income for this bracket, or null for the
  /// top bracket.
  final int? upperBound;
  final double rate;

  /// Progressive quick-deduction (速算控除) subtracted after applying [rate].
  final int deduction;
}

class JpIncomeTaxEstimate {
  const JpIncomeTaxEstimate({
    required this.taxableIncome,
    required this.nationalTax,
    required this.reconstructionSurtax,
    required this.residentsTaxApprox,
    required this.appliedRatePercent,
  });

  final int taxableIncome;
  final int nationalTax;
  final int reconstructionSurtax;
  final int residentsTaxApprox;

  /// The marginal national bracket rate applied, as a whole percent.
  final int appliedRatePercent;

  int get nationalPlusSurtax => nationalTax + reconstructionSurtax;
  int get totalEstimate => nationalTax + reconstructionSurtax + residentsTaxApprox;
}

abstract final class JpIncomeTaxEstimator {
  /// National income-tax brackets (2023 onward), in yen of taxable income.
  static const List<JpIncomeTaxBracket> _brackets = [
    JpIncomeTaxBracket(1950000, 0.05, 0),
    JpIncomeTaxBracket(3300000, 0.10, 97500),
    JpIncomeTaxBracket(6950000, 0.20, 427500),
    JpIncomeTaxBracket(9000000, 0.23, 636000),
    JpIncomeTaxBracket(18000000, 0.33, 1536000),
    JpIncomeTaxBracket(40000000, 0.40, 2796000),
    JpIncomeTaxBracket(null, 0.45, 4796000),
  ];

  static const double _reconstructionSurtaxRate = 0.021;
  static const double _residentsTaxRate = 0.10;
  static const int _residentsPerCapita = 5000;

  /// Estimates tax on [taxableIncome] (net business income after the blue-return
  /// deduction and other deductions), in whole yen. Negative income yields zero.
  static JpIncomeTaxEstimate estimate(int taxableIncome) {
    if (taxableIncome <= 0) {
      return const JpIncomeTaxEstimate(
        taxableIncome: 0,
        nationalTax: 0,
        reconstructionSurtax: 0,
        residentsTaxApprox: 0,
        appliedRatePercent: 0,
      );
    }

    final bracket = _brackets.firstWhere(
      (b) => b.upperBound == null || taxableIncome <= b.upperBound!,
    );

    final national =
        (taxableIncome * bracket.rate).floor() - bracket.deduction;
    final nationalTax = national < 0 ? 0 : national;
    final surtax = (nationalTax * _reconstructionSurtaxRate).floor();
    final residents =
        (taxableIncome * _residentsTaxRate).floor() + _residentsPerCapita;

    return JpIncomeTaxEstimate(
      taxableIncome: taxableIncome,
      nationalTax: nationalTax,
      reconstructionSurtax: surtax,
      residentsTaxApprox: residents,
      appliedRatePercent: (bracket.rate * 100).round(),
    );
  }
}
