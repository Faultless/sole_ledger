import 'receipt_image.dart';
import 'receipt_parser.dart';
// Web has no offline OCR engine, so it compiles the stub; native platforms
// (dart.library.io present) compile the ML Kit implementation.
import 'ocr_engine_stub.dart' if (dart.library.io) 'ocr_engine_io.dart' as engine;

export 'receipt_parser.dart' show ScannedReceipt;

/// Whether on-device OCR is available on this platform. True only on Android/iOS
/// (ML Kit); false on web and desktop, where the editor falls back to attach +
/// manual entry.
bool get ocrSupported => engine.ocrSupported;

/// Runs OCR on [receipt] and parses the recognised text into best-effort
/// bookkeeping fields. Returns null when OCR is unavailable or found no text.
/// Callers must treat the result as a pre-fill to be verified, never as truth.
Future<ScannedReceipt?> scanReceipt(PickedReceipt receipt) async {
  if (!ocrSupported) return null;
  final text = await engine.recognizeText(receipt);
  if (text == null || text.trim().isEmpty) return null;
  return parseReceiptText(text);
}
