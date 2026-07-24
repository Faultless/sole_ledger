import 'receipt_image.dart';

/// Web/desktop fallback: no offline OCR engine available.
bool get ocrSupported => false;

Future<String?> recognizeText(PickedReceipt receipt) async => null;
