import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/domain/enums.dart';
import 'package:sole_ledger/domain/tax/report_period.dart';

void main() {
  group('quarterly', () {
    test('spans its three months', () {
      final p = ReportPeriod.ofQuarter(2026, Quarter.q3);
      expect(p.start, DateTime(2026, 7, 1));
      expect(p.endExclusive, DateTime(2026, 10, 1));
      expect(p.endInclusive, DateTime(2026, 9, 30));
      expect(p.slug, '2026-Q3');
    });

    test('Q4 rolls into the next year', () {
      final p = ReportPeriod.ofQuarter(2026, Quarter.q4);
      expect(p.endExclusive, DateTime(2027, 1, 1));
      expect(p.endInclusive, DateTime(2026, 12, 31));
    });
  });

  group('monthly', () {
    test('spans exactly one month', () {
      final p = ReportPeriod.ofMonth(2026, 8);
      expect(p.start, DateTime(2026, 8, 1));
      expect(p.endExclusive, DateTime(2026, 9, 1));
      expect(p.endInclusive, DateTime(2026, 8, 31));
      expect(p.slug, '2026-08');
    });

    test('handles February in a leap year', () {
      final p = ReportPeriod.ofMonth(2028, 2);
      expect(p.endInclusive, DateTime(2028, 2, 29));
    });

    test('December rolls into the next year', () {
      final p = ReportPeriod.ofMonth(2026, 12);
      expect(p.endExclusive, DateTime(2027, 1, 1));
      expect(p.endInclusive, DateTime(2026, 12, 31));
      expect(p.slug, '2026-12');
    });

    test('knows the quarter it falls in', () {
      expect(ReportPeriod.ofMonth(2026, 8).quarter, Quarter.q3);
      expect(ReportPeriod.ofMonth(2026, 1).quarter, Quarter.q1);
    });

    test('an out-of-range month is pinned inside the year', () {
      expect(ReportPeriod.ofMonth(2026, 0).start, DateTime(2026, 1, 1));
      expect(ReportPeriod.ofMonth(2026, 13).start, DateTime(2026, 12, 1));
    });
  });

  test('the twelve months tile the four quarters exactly', () {
    for (final q in Quarter.values) {
      final quarterly = ReportPeriod.ofQuarter(2026, q);
      final months = [
        for (var m = q.firstMonth; m <= q.lastMonth; m++)
          ReportPeriod.ofMonth(2026, m),
      ];
      expect(months.first.start, quarterly.start);
      expect(months.last.endExclusive, quarterly.endExclusive);
      // No gap and no overlap between consecutive months.
      for (var i = 1; i < months.length; i++) {
        expect(months[i].start, months[i - 1].endExclusive);
      }
    }
  });
}
