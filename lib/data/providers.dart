import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/format/formatters.dart';
import '../domain/enums.dart';
import 'db/database.dart';
import 'repositories/app_repository.dart';

/// The Drift database. One instance for the app's lifetime.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider = Provider<AppRepository>(
  (ref) => AppRepository(ref.watch(databaseProvider)),
);

/// The singleton business profile, streamed. Null until [ensureBusinessProfile]
/// has run (done at startup).
final businessProfileProvider = StreamProvider<BusinessProfile?>(
  (ref) => ref.watch(repositoryProvider).watchBusinessProfile(),
);

/// The active app language, derived from the saved business profile.
final appLanguageProvider = Provider<AppLanguage>((ref) {
  final profile = ref.watch(businessProfileProvider).value;
  return AppLanguage.fromCode(profile?.defaultLanguage ?? 'en');
});

/// Locale-aware formatters for the current language.
final formattersProvider = Provider<Formatters>(
  (ref) => Formatters(ref.watch(appLanguageProvider).code),
);

final clientsProvider = StreamProvider<List<Client>>(
  (ref) => ref.watch(repositoryProvider).watchClients(),
);

final unbilledMinutesProvider = StreamProvider<int>(
  (ref) => ref.watch(repositoryProvider).watchUnbilledMinutes(),
);

final monthMinutesProvider = StreamProvider<int>((ref) {
  final now = DateTime.now();
  final from = DateTime(now.year, now.month, 1);
  final to = DateTime(now.year, now.month + 1, 1);
  return ref.watch(repositoryProvider).watchMinutesBetween(from, to);
});

final invoicesProvider = StreamProvider<List<Invoice>>(
  (ref) => ref.watch(repositoryProvider).watchInvoices(),
);

final outstandingInvoicesProvider = StreamProvider<List<Invoice>>(
  (ref) => ref
      .watch(repositoryProvider)
      .watchInvoicesByStatus([InvoiceStatus.sent.name, InvoiceStatus.overdue.name]),
);

final projectsProvider = StreamProvider.family<List<Project>, String>(
  (ref, clientId) => ref.watch(repositoryProvider).watchProjects(clientId),
);

final expensesProvider = StreamProvider<List<Expense>>(
  (ref) => ref.watch(repositoryProvider).watchExpenses(),
);

final invoiceProvider = StreamProvider.family<Invoice?, String>(
  (ref, id) => ref.watch(repositoryProvider).watchInvoice(id),
);

final invoiceLinesProvider = FutureProvider.family<List<InvoiceLine>, String>(
  (ref, id) => ref.watch(repositoryProvider).invoiceLines(id),
);

final clientProvider = FutureProvider.family<Client?, String>(
  (ref, id) => ref.watch(repositoryProvider).findClient(id),
);

/// Time entries for the current month (used by the Time screen).
final monthTimeEntriesProvider = StreamProvider<List<TimeEntry>>((ref) {
  final now = DateTime.now();
  final from = DateTime(now.year, now.month, 1);
  final to = DateTime(now.year, now.month + 1, 1);
  return ref.watch(repositoryProvider).watchTimeEntries(from: from, to: to);
});
