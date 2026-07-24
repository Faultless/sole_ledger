import 'dart:io';

import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

import 'receipt_image.dart';

/// ML Kit ships on-device recognizers for Android and iOS only. On desktop the
/// plugin has no implementation, so we report unsupported and never call it.
bool get ocrSupported =>
    defaultTargetPlatform == TargetPlatform.android ||
    defaultTargetPlatform == TargetPlatform.iOS;

/// Recognises text from the receipt using the Latin-script model (bundled and
/// fully offline). Latin reliably captures the digits, dates and Latin keywords
/// (Total/BTW) we key off; Japanese kanji keywords are handled positionally by
/// the parser. Prefers the originally picked file; falls back to a temp file.
Future<String?> recognizeText(PickedReceipt receipt) async {
  if (!ocrSupported) return null;

  File? temp;
  String path;
  if (receipt.sourcePath != null) {
    path = receipt.sourcePath!;
  } else {
    final dir = await getTemporaryDirectory();
    temp = File('${dir.path}/ocr_${DateTime.now().microsecondsSinceEpoch}.jpg');
    await temp.writeAsBytes(receipt.bytes);
    path = temp.path;
  }

  final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  try {
    final result = await recognizer.processImage(InputImage.fromFilePath(path));
    return result.text;
  } finally {
    await recognizer.close();
    if (temp != null) {
      try {
        await temp.delete();
      } catch (_) {
        // Best-effort cleanup; a leftover temp file is harmless.
      }
    }
  }
}
