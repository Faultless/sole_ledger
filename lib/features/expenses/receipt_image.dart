import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

/// A receipt image ready to store: [bytes] is a compressed JPEG suitable for the
/// in-DB blob, [mime] its content type. [sourcePath] is the on-device file path
/// of the originally picked image when available (null on web) — OCR reads it
/// directly, which is more reliable than re-decoding the compressed copy.
class PickedReceipt {
  const PickedReceipt({
    required this.bytes,
    required this.mime,
    this.sourcePath,
  });

  final Uint8List bytes;
  final String mime;
  final String? sourcePath;
}

/// Longest edge (px) we keep. Receipts stay legible well below this while the
/// stored blob lands around 100–200 KB.
const int _maxDim = 1600;
const int _jpegQuality = 80;

final ImagePicker _picker = ImagePicker();

/// Picks a receipt image from [source] (camera or gallery/file dialog), then
/// downscales and re-encodes it to a bounded JPEG. Returns null if the user
/// cancels. Works on every platform image_picker supports; the compression
/// guarantees a bounded blob even on web/desktop where image_picker ignores its
/// own resize hints.
Future<PickedReceipt?> pickReceipt(ImageSource source) async {
  // image_picker has no desktop implementation, so a gallery pick on
  // macOS/Linux/Windows goes through file_selector instead. Camera is only
  // offered on mobile (where the scan button appears), so it stays on
  // image_picker.
  final isDesktop = !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.windows);

  final XFile? file;
  if (isDesktop && source == ImageSource.gallery) {
    file = await fs.openFile(acceptedTypeGroups: const [
      fs.XTypeGroup(
        label: 'Images',
        extensions: ['jpg', 'jpeg', 'png', 'heic', 'heif', 'webp'],
      ),
    ]);
  } else {
    file = await _picker.pickImage(
      source: source,
      // Honoured natively on mobile; harmless elsewhere. Final bound is enforced
      // by _compress below regardless of platform.
      maxWidth: _maxDim.toDouble(),
      maxHeight: _maxDim.toDouble(),
      imageQuality: _jpegQuality,
    );
  }
  if (file == null) return null;
  final raw = await file.readAsBytes();
  final bytes = await compute(_compress, raw);
  return PickedReceipt(
    bytes: bytes,
    mime: 'image/jpeg',
    sourcePath: kIsWeb ? null : file.path,
  );
}

/// Decodes, downscales to [_maxDim] on the longest edge, and JPEG-encodes.
/// Runs in a background isolate via [compute] on native; on web it executes on
/// the main thread (no isolates) which is acceptable for a single receipt.
/// Falls back to the original bytes if decoding fails (e.g. an exotic format).
Uint8List _compress(Uint8List raw) {
  final decoded = img.decodeImage(raw);
  if (decoded == null) return raw;
  final longest = decoded.width >= decoded.height ? decoded.width : decoded.height;
  final resized = longest > _maxDim
      ? img.copyResize(
          decoded,
          width: decoded.width >= decoded.height ? _maxDim : null,
          height: decoded.height > decoded.width ? _maxDim : null,
        )
      : decoded;
  return img.encodeJpg(resized, quality: _jpegQuality);
}
