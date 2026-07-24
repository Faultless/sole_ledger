// Resolves where the native database file lives. Isolated behind a conditional
// import because computing a home-directory path needs dart:io, which must not
// be imported into database.dart (that file is also compiled for the web).
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
/// that use the drift default (mobile) or OPFS (web).
Future<String?> currentDatabasePath() => impl.currentDatabasePath();
