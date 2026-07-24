// Web fallback: no filesystem, so no fixed path — the web build uses OPFS.
Future<String> Function()? fixedDatabasePath() => null;

Future<String?> currentDatabasePath() async => null;
