// Resolves where the native database file lives. Isolated behind a conditional
// import because computing a home-directory path needs dart:io, which must not
// be imported into database.dart (that file is also compiled for the web).
import 'dart:typed_data';

import 'db_location_stub.dart' if (dart.library.io) 'db_location_io.dart' as impl;

/// A `databasePath` callback for drift_flutter's [DriftNativeOptions], or null
/// to keep the platform default.
///
/// On **desktop** (macOS/Linux/Windows) this points the database at a fixed,
/// user-visible folder — `~/SoleLedger/sole_ledger.sqlite` by default, or
/// `$SOLE_LEDGER_DIR` if set — so Syncthing can sync the single ledger file.
/// On **mobile** it returns null, keeping drift's app-documents default. On
/// **web** it returns null (the web build uses OPFS via DriftWebOptions).
Future<String> Function()? fixedDatabasePath() => impl.fixedDatabasePath();

/// The resolved database file path, for display in Settings. Null on platforms
/// that use the drift default (iOS, Android before sync is enabled) or OPFS (web).
Future<String?> currentDatabasePath() => impl.currentDatabasePath();

/// Whether this platform offers a Settings action to move the database into a
/// shared, syncer-reachable folder (Android only; desktop is already external).
bool get canEnableExternalSync => impl.canEnableExternalSync;

/// Android: request "All files access" and copy the current database into the
/// shared `/sdcard/SoleLedger` folder so Syncthing can reach it. Returns true if
/// granted; the app must then be restarted. No-op (false) elsewhere.
Future<bool> enableExternalSync() => impl.enableExternalSync();

/// The current database file's bytes, for a backup/export. Null on web (no file)
/// or if the file isn't found.
Future<Uint8List?> readDatabaseBytes() => impl.readDatabaseBytes();
