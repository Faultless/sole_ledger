import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'data/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // One container we control, so we can guarantee the singleton business
  // profile row exists before the first frame reads it.
  final container = ProviderContainer();
  await container.read(repositoryProvider).ensureBusinessProfile();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SoleLedgerApp(),
    ),
  );
}
