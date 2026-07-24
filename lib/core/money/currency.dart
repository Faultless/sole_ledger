/// Supported invoicing/reporting currencies.
///
/// [decimals] is the number of minor-unit digits used by the currency:
/// EUR/USD use 2 (cents), JPY uses 0 (yen has no sub-unit). All monetary
/// amounts are stored as integer minor units to avoid floating-point drift.
enum Currency {
  eur(code: 'EUR', symbol: '€', decimals: 2),
  jpy(code: 'JPY', symbol: '¥', decimals: 0),
  usd(code: 'USD', symbol: '\$', decimals: 2);

  const Currency({
    required this.code,
    required this.symbol,
    required this.decimals,
  });

  final String code;
  final String symbol;
  final int decimals;

  /// Number of minor units in one major unit (100 for EUR, 1 for JPY).
  int get minorPerMajor {
    var factor = 1;
    for (var i = 0; i < decimals; i++) {
      factor *= 10;
    }
    return factor;
  }

  static Currency fromCode(String code) => Currency.values.firstWhere(
        (c) => c.code == code.toUpperCase(),
        orElse: () => Currency.eur,
      );
}
