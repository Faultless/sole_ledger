/// Depreciation (減価償却) of fixed assets for a Japanese sole proprietor.
///
/// An asset (cost ≥ ¥100,000, useful life > 1 year) can't be expensed all at
/// once; its cost is spread across years. This models the three common paths:
///
///  * [DepreciationMethod.fullExpense] — 少額減価償却資産の特例: blue-return filers
///    may fully deduct assets under ¥300,000 in the acquisition year
///    (annual cap ¥3M, not enforced here — that's a filing concern).
///  * [DepreciationMethod.lumpThreeYear] — 一括償却資産: assets ¥100k–¥200k may be
///    written off evenly over three years, ignoring useful life.
///  * [DepreciationMethod.straightLine] — 定額法: cost ÷ useful life per year,
///    the first year prorated by months in service (月割), leaving a ¥1 memo value.
///
/// All figures are ESTIMATES for planning; the filed 減価償却 may differ.
/// Amounts are in the asset's minor units (yen has none, so minor == yen).
library;

enum DepreciationMethod {
  fullExpense,
  lumpThreeYear,
  straightLine;

  static DepreciationMethod fromName(String name) => values.firstWhere(
        (m) => m.name == name,
        orElse: () => DepreciationMethod.straightLine,
      );
}

abstract final class Depreciation {
  /// Gross depreciation (before business-use apportionment) for [year].
  static int grossForYear({
    required int costMinor,
    required DateTime acquisition,
    required DepreciationMethod method,
    required int usefulLifeYears,
    required int year,
  }) =>
      _schedule(costMinor, acquisition, method, usefulLifeYears)[year] ?? 0;

  /// Total gross depreciation booked from acquisition through [year] inclusive.
  static int grossAccumulatedThrough({
    required int costMinor,
    required DateTime acquisition,
    required DepreciationMethod method,
    required int usefulLifeYears,
    required int year,
  }) =>
      _schedule(costMinor, acquisition, method, usefulLifeYears)
          .entries
          .where((e) => e.key <= year)
          .fold(0, (sum, e) => sum + e.value);

  /// Remaining book value (簿価) at the end of [year].
  static int bookValueAtEndOf({
    required int costMinor,
    required DateTime acquisition,
    required DepreciationMethod method,
    required int usefulLifeYears,
    required int year,
  }) =>
      costMinor -
      grossAccumulatedThrough(
        costMinor: costMinor,
        acquisition: acquisition,
        method: method,
        usefulLifeYears: usefulLifeYears,
        year: year,
      );

  /// The deductible slice for [year] after applying [businessUsePercent].
  static int deductibleForYear({
    required int costMinor,
    required DateTime acquisition,
    required DepreciationMethod method,
    required int usefulLifeYears,
    required int businessUsePercent,
    required int year,
  }) {
    final gross = grossForYear(
      costMinor: costMinor,
      acquisition: acquisition,
      method: method,
      usefulLifeYears: usefulLifeYears,
      year: year,
    );
    return (gross * businessUsePercent / 100).round();
  }

  /// year → gross depreciation booked that year.
  static Map<int, int> _schedule(
    int costMinor,
    DateTime acquisition,
    DepreciationMethod method,
    int usefulLifeYears,
  ) {
    final start = acquisition.year;
    final out = <int, int>{};
    if (costMinor <= 0) return out;

    switch (method) {
      case DepreciationMethod.fullExpense:
        out[start] = costMinor;

      case DepreciationMethod.lumpThreeYear:
        final base = costMinor ~/ 3;
        out[start] = base;
        out[start + 1] = base;
        out[start + 2] = costMinor - 2 * base; // remainder in the final year

      case DepreciationMethod.straightLine:
        final life = usefulLifeYears < 1 ? 1 : usefulLifeYears;
        final annual = costMinor / life;
        final monthsYear1 = 12 - acquisition.month + 1;
        // Leave a ¥1 (one minor unit) memo value once fully depreciated.
        final maxTotal = costMinor > 1 ? costMinor - 1 : costMinor;
        var acc = 0;
        var y = start;
        for (var i = 0; i <= life + 1; i++) {
          final frac = i == 0 ? monthsYear1 / 12.0 : 1.0;
          var dep = (annual * frac).floor();
          if (acc + dep > maxTotal) dep = maxTotal - acc;
          if (dep <= 0) break;
          out[y] = dep;
          acc += dep;
          y++;
          if (acc >= maxTotal) break;
        }
    }
    return out;
  }
}
