import 'package:intl/intl.dart';

import '../money/money.dart';

/// Locale-aware formatting for money, dates and durations.
///
/// Currency formatting respects each currency's own decimal count (0 for JPY,
/// 2 for EUR/USD) while grouping/decimal separators follow the active [locale]
/// (e.g. `€ 1.234,56` in nl, `€1,234.56` in en).
class Formatters {
  Formatters(this.locale);
  final String locale;

  String money(Money amount) {
    final f = NumberFormat.currency(
      locale: locale,
      symbol: amount.currency.symbol,
      decimalDigits: amount.currency.decimals,
    );
    return f.format(amount.asMajor);
  }

  /// Money without the symbol (for right-aligned table columns with a separate
  /// currency header).
  String amount(Money value) {
    final f = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: value.currency.decimals,
    );
    return f.format(value.asMajor);
  }

  String date(DateTime d) => DateFormat.yMMMd(locale).format(d);
  String dateNumeric(DateTime d) => DateFormat.yMd(locale).format(d);
  String monthYear(DateTime d) => DateFormat.yMMMM(locale).format(d);

  /// Formats whole minutes as decimal hours, e.g. 90 -> "1.5 h".
  String hoursFromMinutes(int minutes) {
    final hours = minutes / 60.0;
    final f = NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 2);
    return '${f.format(hours)} h';
  }

  /// Formats whole minutes as `h:mm`, e.g. 90 -> "1:30".
  String clockFromMinutes(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return '$h:${m.toString().padLeft(2, '0')}';
  }
}
