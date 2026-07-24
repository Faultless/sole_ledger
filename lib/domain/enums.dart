/// UI + report language. Values map to locale codes used by gen-l10n.
enum AppLanguage {
  english('en', 'English'),
  dutch('nl', 'Nederlands'),
  japanese('ja', '日本語');

  const AppLanguage(this.code, this.nativeName);
  final String code;
  final String nativeName;

  static AppLanguage fromCode(String code) => AppLanguage.values.firstWhere(
        (l) => l.code == code,
        orElse: () => AppLanguage.english,
      );
}

/// Lifecycle of an invoice.
enum InvoiceStatus {
  draft,
  sent,
  paid,
  overdue,
  cancelled;

  static InvoiceStatus byName(String name) => InvoiceStatus.values.firstWhere(
        (s) => s.name == name,
        orElse: () => InvoiceStatus.draft,
      );
}

/// Rounding applied to a single time entry's duration before it is billed.
enum TimeRounding {
  none(0),
  toFiveMinutes(5),
  toSixMinutes(6), // tenth-of-an-hour billing
  toFifteenMinutes(15),
  toThirtyMinutes(30),
  toHour(60);

  const TimeRounding(this.minutes);
  final int minutes;
}

/// A calendar quarter, used for periodic (VAT) reporting.
enum Quarter {
  q1(1, 1, 3),
  q2(2, 4, 6),
  q3(3, 7, 9),
  q4(4, 10, 12);

  const Quarter(this.number, this.firstMonth, this.lastMonth);
  final int number;
  final int firstMonth;
  final int lastMonth;

  static Quarter ofMonth(int month) =>
      Quarter.values.firstWhere((q) => month >= q.firstMonth && month <= q.lastMonth);

  DateTime start(int year) => DateTime(year, firstMonth, 1);
  DateTime endExclusive(int year) => DateTime(year, lastMonth + 1, 1);
}
