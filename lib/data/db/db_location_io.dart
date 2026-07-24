import 'dart:io';

import 'package:path/path.dart' as p;

/// Directory name under the user's home where the ledger lives by default.
const _folderName = 'SoleLedger';
const _fileName = 'sole_ledger.sqlite';

/// Desktop: pin the database to a fixed, user-visible folder so Syncthing can
/// sync it. Mobile keeps drift's app-documents default (returns null), because
/// Android/iOS app storage isn't a shared location a file syncer can reach.
Future<String> Function()? fixedDatabasePath() {
  final isDesktop = Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  if (!isDesktop) return null;

  return () async {
    final override = Platform.environment['SOLE_LEDGER_DIR'];
    final home = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        Directory.current.path;
    final dir = Directory(
      (override != null && override.isNotEmpty)
          ? override
          : p.join(home, _folderName),
    );
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return p.join(dir.path, _fileName);
  };
}

/// The resolved database file path for display (Settings) and diagnostics, or
/// null on platforms using the drift default.
Future<String?> currentDatabasePath() async {
  final resolver = fixedDatabasePath();
  if (resolver == null) return null;
  return resolver();
}
