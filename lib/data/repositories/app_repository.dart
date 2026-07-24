import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/enums.dart';
import '../db/database.dart';

/// Single entry point for persistence. Keeps Drift specifics out of the UI and
/// centralises invariants (e.g. exactly one business profile, invoice
/// numbering).
class AppRepository {
  AppRepository(this.db);
  final AppDatabase db;
  static const _uuid = Uuid();

  String newId() => _uuid.v4();

  // --- Business profile ----------------------------------------------------

  static const _profileId = 'default';

  /// Ensures the singleton business profile row exists and returns it.
  Future<BusinessProfile> ensureBusinessProfile() async {
    final existing = await (db.select(db.businessProfiles)
          ..where((t) => t.id.equals(_profileId)))
        .getSingleOrNull();
    if (existing != null) return existing;

    await db.into(db.businessProfiles).insert(
          BusinessProfilesCompanion.insert(
            id: _profileId,
            tradeName: const Value('Frontendienst'),
          ),
        );
    return (db.select(db.businessProfiles)
          ..where((t) => t.id.equals(_profileId)))
        .getSingle();
  }

  Stream<BusinessProfile?> watchBusinessProfile() =>
      (db.select(db.businessProfiles)..where((t) => t.id.equals(_profileId)))
          .watchSingleOrNull();

  Future<void> saveBusinessProfile(BusinessProfilesCompanion companion) async {
    await db.into(db.businessProfiles).insertOnConflictUpdate(
          companion.copyWith(id: const Value(_profileId)),
        );
  }

  // --- Clients -------------------------------------------------------------

  Stream<List<Client>> watchClients({bool includeArchived = false}) {
    final query = db.select(db.clients)
      ..orderBy([(t) => OrderingTerm(expression: t.name)]);
    if (!includeArchived) {
      query.where((t) => t.archived.equals(false));
    }
    return query.watch();
  }

  Future<Client?> findClient(String id) =>
      (db.select(db.clients)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertClient(ClientsCompanion companion) =>
      db.into(db.clients).insertOnConflictUpdate(companion);

  // --- Projects (per client) ----------------------------------------------

  Stream<List<Project>> watchProjects(String clientId,
      {bool includeInactive = true}) {
    final query = db.select(db.projects)
      ..where((t) => t.clientId.equals(clientId))
      ..orderBy([(t) => OrderingTerm(expression: t.name)]);
    if (!includeInactive) query.where((t) => t.active.equals(true));
    return query.watch();
  }

  Future<List<Project>> projectsForClient(String clientId) =>
      (db.select(db.projects)
            ..where((t) => t.clientId.equals(clientId) & t.active.equals(true))
            ..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .get();

  Future<void> upsertProject(ProjectsCompanion companion) =>
      db.into(db.projects).insertOnConflictUpdate(companion);

  Future<void> deleteProject(String id) =>
      (db.delete(db.projects)..where((t) => t.id.equals(id))).go();

  // --- Expenses ------------------------------------------------------------

  Stream<List<Expense>> watchExpenses({int? year}) {
    final query = db.select(db.expenses)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
      ]);
    if (year != null) {
      query.where((t) =>
          t.date.isBiggerOrEqualValue(DateTime(year, 1, 1)) &
          t.date.isSmallerThanValue(DateTime(year + 1, 1, 1)));
    }
    return query.watch();
  }

  Future<void> upsertExpense(ExpensesCompanion companion) =>
      db.into(db.expenses).insertOnConflictUpdate(companion);

  Future<void> deleteExpense(String id) =>
      (db.delete(db.expenses)..where((t) => t.id.equals(id))).go();

  // --- Time entries --------------------------------------------------------

  Stream<List<TimeEntry>> watchTimeEntries({DateTime? from, DateTime? to}) {
    final query = db.select(db.timeEntries)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
      ]);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerThanValue(to));
    return query.watch();
  }

  Future<void> upsertTimeEntry(TimeEntriesCompanion companion) =>
      db.into(db.timeEntries).insertOnConflictUpdate(companion);

  Future<void> deleteTimeEntry(String id) =>
      (db.delete(db.timeEntries)..where((t) => t.id.equals(id))).go();

  /// Sum of billable, uninvoiced minutes across all time (for the dashboard).
  Stream<int> watchUnbilledMinutes() {
    final sum = db.timeEntries.minutes.sum();
    final query = db.selectOnly(db.timeEntries)
      ..addColumns([sum])
      ..where(db.timeEntries.billable.equals(true) &
          db.timeEntries.invoiceId.isNull());
    return query.watchSingle().map((row) => row.read(sum) ?? 0);
  }

  Stream<int> watchMinutesBetween(DateTime from, DateTime to) {
    final sum = db.timeEntries.minutes.sum();
    final query = db.selectOnly(db.timeEntries)
      ..addColumns([sum])
      ..where(db.timeEntries.date.isBiggerOrEqualValue(from) &
          db.timeEntries.date.isSmallerThanValue(to));
    return query.watchSingle().map((row) => row.read(sum) ?? 0);
  }

  // --- Invoices ------------------------------------------------------------

  Stream<List<Invoice>> watchInvoices() {
    return (db.select(db.invoices)
          ..orderBy([
            (t) => OrderingTerm(expression: t.issueDate, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Stream<List<Invoice>> watchInvoicesByStatus(List<String> statuses) {
    return (db.select(db.invoices)
          ..where((t) => t.status.isIn(statuses))
          ..orderBy([(t) => OrderingTerm(expression: t.issueDate)]))
        .watch();
  }

  Future<List<InvoiceLine>> invoiceLines(String invoiceId) =>
      (db.select(db.invoiceLines)
            ..where((t) => t.invoiceId.equals(invoiceId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();

  Future<Invoice?> findInvoice(String id) =>
      (db.select(db.invoices)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Invoice?> watchInvoice(String id) =>
      (db.select(db.invoices)..where((t) => t.id.equals(id)))
          .watchSingleOrNull();

  /// Billable, not-yet-invoiced time entries for a client, oldest first.
  Future<List<TimeEntry>> unbilledEntriesForClient(String clientId) {
    return (db.select(db.timeEntries)
          ..where((t) =>
              t.clientId.equals(clientId) &
              t.billable.equals(true) &
              t.invoiceId.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.date)]))
        .get();
  }

  /// Creates an invoice with its lines in one transaction and links the given
  /// time entries to it (so they no longer count as unbilled).
  Future<void> createInvoice({
    required InvoicesCompanion invoice,
    required List<InvoiceLinesCompanion> lines,
    required List<String> timeEntryIds,
  }) async {
    await db.transaction(() async {
      await db.into(db.invoices).insert(invoice);
      for (final line in lines) {
        await db.into(db.invoiceLines).insert(line);
      }
      if (timeEntryIds.isNotEmpty) {
        await (db.update(db.timeEntries)
              ..where((t) => t.id.isIn(timeEntryIds)))
            .write(TimeEntriesCompanion(invoiceId: Value(invoice.id.value)));
      }
    });
  }

  // --- Reporting queries (point-in-time reads over a period) ---------------

  Future<List<Client>> allClientsOnce() =>
      (db.select(db.clients)
            ..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .get();

  Future<List<TimeEntry>> timeEntriesBetween(DateTime from, DateTime to) =>
      (db.select(db.timeEntries)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(from) &
                t.date.isSmallerThanValue(to))
            ..orderBy([(t) => OrderingTerm(expression: t.date)]))
          .get();

  Future<List<Expense>> expensesBetween(DateTime from, DateTime to) =>
      (db.select(db.expenses)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(from) &
                t.date.isSmallerThanValue(to))
            ..orderBy([(t) => OrderingTerm(expression: t.date)]))
          .get();

  /// Invoices issued within [from, to) paired with their lines — the input for
  /// the quarterly VAT and annual income reports.
  Future<List<({Invoice invoice, List<InvoiceLine> lines})>>
      invoicesWithLinesBetween(DateTime from, DateTime to) async {
    final invoices = await (db.select(db.invoices)
          ..where((t) =>
              t.issueDate.isBiggerOrEqualValue(from) &
              t.issueDate.isSmallerThanValue(to) &
              t.status.isNotIn([InvoiceStatus.cancelled.name]))
          ..orderBy([(t) => OrderingTerm(expression: t.issueDate)]))
        .get();
    final result = <({Invoice invoice, List<InvoiceLine> lines})>[];
    for (final inv in invoices) {
      result.add((invoice: inv, lines: await invoiceLines(inv.id)));
    }
    return result;
  }

  Future<void> setInvoiceStatus(String id, String status,
      {DateTime? paidDate}) async {
    await (db.update(db.invoices)..where((t) => t.id.equals(id))).write(
      InvoicesCompanion(
        status: Value(status),
        paidDate: Value(paidDate),
      ),
    );
  }

  /// Deletes an invoice, releasing its time entries back to unbilled.
  Future<void> deleteInvoice(String id) async {
    await db.transaction(() async {
      await (db.update(db.timeEntries)..where((t) => t.invoiceId.equals(id)))
          .write(const TimeEntriesCompanion(invoiceId: Value(null)));
      await (db.delete(db.invoiceLines)..where((t) => t.invoiceId.equals(id)))
          .go();
      await (db.delete(db.invoices)..where((t) => t.id.equals(id))).go();
    });
  }

  /// Reserves and returns the next invoice number, advancing the sequence.
  Future<String> nextInvoiceNumber() async {
    return db.transaction(() async {
      final profile = await ensureBusinessProfile();
      final seq = profile.nextInvoiceSeq;
      final year = DateTime.now().year;
      final number =
          '${profile.invoiceNumberPrefix}-$year-${seq.toString().padLeft(4, '0')}';
      await (db.update(db.businessProfiles)
            ..where((t) => t.id.equals(_profileId)))
          .write(BusinessProfilesCompanion(nextInvoiceSeq: Value(seq + 1)));
      return number;
    });
  }
}
