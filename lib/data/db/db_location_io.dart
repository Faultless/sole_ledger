import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Directory name (under the user's home on desktop, or shared storage on
/// Android) where the ledger lives.
const _folderName = 'SoleLedger';
const _fileName = 'sole_ledger.sqlite';

/// Returns a databasePath callback so the DB lands where a file syncer can see
/// it, or null to keep the platform default (drift's app-documents dir).
///
/// - **Desktop**: fixed `~/SoleLedger/…` (override `$SOLE_LEDGER_DIR`).
/// - **Android**: shared `/sdcard/SoleLedger/…` when the user has granted "All
///   files access" (see [enableExternalSync]); otherwise the private
///   app-documents path, so the app always works. The callback always resolves
///   to a real path — drift requires non-null.
/// - **iOS**: null (no shared, syncer-reachable location; use the default).
Future<String> Function()? fixedDatabasePath() {
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    return _desktopPath;
  }
  if (Platform.isAndroid) {
    return _androidPath;
  }
  return null;
}

Future<String> _desktopPath() async {
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
}

/// Shared folder when sync is enabled, else the private app-documents path
/// (identical to drift's default, so a non-synced Android install is unchanged).
Future<String> _androidPath() async {
  if (await Permission.manageExternalStorage.isGranted) {
    final dir = await _androidSyncDir();
    await dir.create(recursive: true);
    return p.join(dir.path, _fileName);
  }
  final docs = await getApplicationDocumentsDirectory();
  return p.join(docs.path, _fileName);
}

/// The shared-storage folder on Android, derived from the app-specific external
/// dir (`…/Android/data/<pkg>/files`) by trimming back to the storage root, so
/// we don't hard-code `/storage/emulated/0`.
Future<Directory> _androidSyncDir() async {
  var root = '/storage/emulated/0';
  final ext = await getExternalStorageDirectory();
  if (ext != null) {
    final idx = ext.path.indexOf('/Android/');
    if (idx > 0) root = ext.path.substring(0, idx);
  }
  return Directory(p.join(root, _folderName));
}

/// The resolved database path for display in Settings, or null when the
/// platform/state uses private storage (iOS, or Android before sync is enabled).
Future<String?> currentDatabasePath() async {
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    return _desktopPath();
  }
  if (Platform.isAndroid && await Permission.manageExternalStorage.isGranted) {
    final dir = await _androidSyncDir();
    return p.join(dir.path, _fileName);
  }
  return null;
}

/// Whether this platform offers the "enable external sync folder" action
/// (Android only — desktop is always external, others never).
bool get canEnableExternalSync => Platform.isAndroid;

/// Android: request "All files access" and, on first enable, copy the existing
/// private database into the shared folder so no data is lost. Returns true if
/// the permission is granted. The app must be restarted to reopen from the new
/// location. No-op returning false on other platforms.
Future<bool> enableExternalSync() async {
  if (!Platform.isAndroid) return false;

  final status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) return false;

  final dir = await _androidSyncDir();
  await dir.create(recursive: true);

  // Seed the shared DB from the private one on first enable (copy main file
  // plus any WAL/SHM sidecars so uncommitted pages aren't lost).
  final externalDb = File(p.join(dir.path, _fileName));
  if (!await externalDb.exists()) {
    final docs = await getApplicationDocumentsDirectory();
    for (final suffix in const ['', '-wal', '-shm']) {
      final src = File(p.join(docs.path, '$_fileName$suffix'));
      if (await src.exists()) {
        await src.copy(p.join(dir.path, '$_fileName$suffix'));
      }
    }
  }
  return true;
}
