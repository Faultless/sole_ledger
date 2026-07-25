import 'dart:typed_data';

// Web fallback: no filesystem, so no fixed path — the web build uses OPFS.
Future<String> Function()? fixedDatabasePath() => null;

Future<String?> currentDatabasePath() async => null;

bool get canEnableExternalSync => false;

Future<bool> enableExternalSync() async => false;

Future<Uint8List?> readDatabaseBytes() async => null;
