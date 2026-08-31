import 'currency.dart';

/// An immutable monetary amount stored as integer minor units
/// (cents for EUR/USD, whole yen for JPY) together with its [currency].
///
/// Bookkeeping must never use `double` for money: `0.1 + 0.2 != 0.3` in IEEE
/// floating point, and those errors accumulate across an invoice. All maths
/// here stays in integer minor units; rounding is applied explicitly and only
/// where a real-world rounding step occurs (e.g. applying a tax rate).
class Money implements Comparable<Money> {
  const Money(this.minorUnits, this.currency);

  /// The amount in minor units (e.g. 12345 == €123.45, or ¥12345).
  final int minorUnits;
  final Currency currency;

  factory Money.zero(Currency currency) => Money(0, currency);

  /// Builds a [Money] from a major-unit decimal value (e.g. `123.45`).
  /// Uses half-up rounding to the currency's minor unit.
  factory Money.fromMajor(num major, Currency currency) {
    final scaled = major * currency.minorPerMajor;
    return Money(scaled.round(), currency);
  }

  double get asMajor => minorUnits / currency.minorPerMajor;

  bool get isZero => minorUnits == 0;
  bool get isNegative => minorUnits < 0;

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(minorUnits + other.minorUnits, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(minorUnits - other.minorUnits, currency);
  }

  Money operator -() => Money(-minorUnits, currency);

  /// Multiplies by a scalar (e.g. a quantity of hours) and rounds half-up
  /// to the nearest minor unit.
  Money times(num factor) => Money((minorUnits * factor).round(), currency);

  /// Applies a tax [rate] (as a fraction, e.g. 0.21) and rounds half-up.
  /// This is the single, explicit place tax rounding happens.
  Money taxAt(double rate) => Money((minorUnits * rate).round(), currency);

  /// Treats this amount as VAT-*inclusive* (gross) and returns the embedded VAT
  /// at [ratePercent] (e.g. 10 for Japanese consumption tax): gross × r/(1+r).
  Money vatPortionFromGross(int ratePercent) {
    if (ratePercent <= 0) return Money.zero(currency);
    final r = ratePercent / 100.0;
    return Money((minorUnits * r / (1 + r)).round(), currency);
  }

  /// Treats this amount as a net that must survive a deduction at [rate] and
  /// returns the uplift needed for it to do so: net × r/(1−r). Grossing up by
  /// r% is not the same as adding r% — see [AllowanceMode].
  ///
  /// [rate] is a fraction below 1; at or above 1 no finite uplift preserves the
  /// net, so callers clamp before calling.
  Money grossUpPortionAt(double rate) {
    if (rate <= 0) return Money.zero(currency);
    assert(rate < 1, 'Cannot gross up at a rate of 100% or more (got $rate).');
    if (rate >= 1) return Money.zero(currency);
    return Money((minorUnits * rate / (1 - rate)).round(), currency);
  }

  /// Applies a business-use percentage (家事按分), e.g. 30 → 30%.
  Money proratedBy(int percent) =>
      Money((minorUnits * percent / 100).round(), currency);

  void _assertSameCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError(
        'Currency mismatch: ${currency.code} vs ${other.currency.code}. '
        'Convert to a common currency before combining amounts.',
      );
    }
  }

  @override
  int compareTo(Money other) {
    _assertSameCurrency(other);
    return minorUnits.compareTo(other.minorUnits);
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);

  @override
  String toString() => '${currency.code} ${asMajor.toStringAsFixed(currency.decimals)}';
}

/// Sums a list of [Money], all assumed to share [currency].
Money sumMoney(Iterable<Money> items, Currency currency) {
  var total = 0;
  for (final m in items) {
    if (m.currency != currency) {
      throw ArgumentError('sumMoney received mixed currencies');
    }
    total += m.minorUnits;
  }
  return Money(total, currency);
}
