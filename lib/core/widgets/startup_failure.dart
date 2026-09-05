import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shown when the ledger could not be opened at all.
///
/// The books are a single file, and its whereabouts plus the underlying error
/// are the two things needed to do anything about a failure — so they are on
/// screen and copyable, rather than only in a log nobody will see.
class StartupFailureApp extends StatelessWidget {
  const StartupFailureApp({
    super.key,
    required this.error,
    required this.databasePath,
  });

  final Object error;
  final String? databasePath;

  @override
  Widget build(BuildContext context) {
    final details = [
      error.toString(),
      if (databasePath != null) '\nLedger: $databasePath',
    ].join('\n');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1F6F5C),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      const Icon(Icons.error_outline, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Couldn't open your ledger",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    Text(
                      'Your data has not been changed. The file is still on '
                      'disk at the path below — copy these details before '
                      'doing anything else.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        details,
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () =>
                          Clipboard.setData(ClipboardData(text: details)),
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copy details'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
