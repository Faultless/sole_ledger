import '../enums.dart';

/// Whether a report covers a calendar quarter or a single month.
enum ReportPeriodKind { quarter, month }

/// The span a report covers, as a half-open range `[start, endExclusive)`.
///
/// Not every report can choose: a Dutch BTW-aangifte is filed per quarter, so
/// the VAT report stays quarterly by law. A timesheet is only a record of hours
/// worked, and clients commonly want those per month — hence the choice.
class ReportPeriod {
  const ReportPeriod._({
    required this.kind,
    required this.year,
    required this.month,
    required this.quarter,
  });

  factory ReportPeriod.ofQuarter(int year, Quarter quarter) => ReportPeriod._(
        kind: ReportPeriodKind.quarter,
        year: year,
        month: quarter.firstMonth,
        quarter: quarter,
      );

  /// [month] is 1–12. Out-of-range values are pinned to the year rather than
  /// silently rolling into a neighbouring one, which would export the wrong
  /// hours under the right-looking title.
  factory ReportPeriod.ofMonth(int year, int month) {
    final m = month < 1 ? 1 : (month > 12 ? 12 : month);
    return ReportPeriod._(
      kind: ReportPeriodKind.month,
      year: year,
      month: m,
      quarter: Quarter.ofMonth(m),
    );
  }

  final ReportPeriodKind kind;
  final int year;

  /// First month of the period (1–12).
  final int month;

  /// The quarter this period falls in — its own for a quarterly period, the
  /// containing one for a month.
  final Quarter quarter;

  DateTime get start => switch (kind) {
        ReportPeriodKind.quarter => quarter.start(year),
        ReportPeriodKind.month => DateTime(year, month, 1),
      };

  DateTime get endExclusive => switch (kind) {
        ReportPeriodKind.quarter => quarter.endExclusive(year),
        ReportPeriodKind.month => DateTime(year, month + 1, 1),
      };

  /// The last day inside the period, for "from – to" display.
  DateTime get endInclusive => endExclusive.subtract(const Duration(days: 1));

  /// Sortable filename fragment: `2026-Q3` or `2026-08`. Exports of different
  /// periods must not collide in the downloads folder.
  String get slug => switch (kind) {
        ReportPeriodKind.quarter => '$year-Q${quarter.number}',
        ReportPeriodKind.month => '$year-${month.toString().padLeft(2, '0')}',
      };
}
