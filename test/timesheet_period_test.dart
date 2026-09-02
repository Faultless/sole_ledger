import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/data/db/database.dart';
import 'package:sole_ledger/data/repositories/app_repository.dart';
import 'package:sole_ledger/domain/enums.dart';
import 'package:sole_ledger/domain/tax/report_period.dart';

/// A monthly timesheet must contain exactly the month's hours — the boundary
/// days are where an off-by-one would quietly bill the wrong period.
void main() {
  late AppDatabase db;
  late AppRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = AppRepository(db);
    await repo.upsertClient(
        const ClientsCompanion(id: Value('c1'), name: Value('Acme B.V.')));
    // One 60-minute entry on each of these days.
    for (final d in [
      DateTime(2026, 7, 31), // last day of July
      DateTime(2026, 8, 1), // first day of August
      DateTime(2026, 8, 15),
      DateTime(2026, 8, 31), // last day of August
      DateTime(2026, 9, 1), // first day of September
    ]) {
      await repo.upsertTimeEntry(TimeEntriesCompanion(
        id: Value('e${d.month}-${d.day}'),
        clientId: const Value('c1'),
        date: Value(d),
        minutes: const Value(60),
      ));
    }
  });
  tearDown(() => db.close());

  Future<List<TimeEntry>> entriesFor(ReportPeriod p) =>
      repo.timeEntriesBetween(p.start, p.endExclusive);

  test('a month holds its own days and neither neighbour', () async {
    final august = await entriesFor(ReportPeriod.ofMonth(2026, 8));
    expect(august.map((e) => e.date.day), [1, 15, 31]);
    expect(august.every((e) => e.date.month == 8), isTrue);
  });

  test('the last day of the month is included', () async {
    final july = await entriesFor(ReportPeriod.ofMonth(2026, 7));
    expect(july, hasLength(1));
    expect(july.single.date, DateTime(2026, 7, 31));
  });

  test('the quarter holds the sum of its months', () async {
    final q3 = await entriesFor(ReportPeriod.ofQuarter(2026, Quarter.q3));
    final months = <TimeEntry>[
      for (var m = 7; m <= 9; m++) ...await entriesFor(ReportPeriod.ofMonth(2026, m)),
    ];
    expect(q3.map((e) => e.id).toSet(), months.map((e) => e.id).toSet());
    expect(q3.fold<int>(0, (s, e) => s + e.minutes),
        months.fold<int>(0, (s, e) => s + e.minutes));
  });

  test('an empty month reports nothing rather than failing', () async {
    expect(await entriesFor(ReportPeriod.ofMonth(2026, 2)), isEmpty);
  });
}
