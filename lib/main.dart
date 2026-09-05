import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/widgets/startup_failure.dart';
import 'data/db/db_location.dart';
import 'data/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // One container we control, so we can guarantee the singleton business
  // profile row exists before the first frame reads it.
  final container = ProviderContainer();
  try {
    await container.read(repositoryProvider).ensureBusinessProfile();
  } catch (error, stack) {
    // Opening the ledger is the one thing that must happen before the UI can
    // exist. Failing it used to mean runApp was never reached at all, so the
    // window came up black with nothing to act on — the worst possible way to
    // report a problem with someone's books. Show what went wrong and where
    // the file is instead.
    debugPrintStack(stackTrace: stack, label: '$error');
    runApp(StartupFailureApp(
      error: error,
      databasePath: await currentDatabasePath(),
    ));
    return;
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SoleLedgerApp(),
    ),
  );
}
