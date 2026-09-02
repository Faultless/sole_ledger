import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sole_ledger/features/settings/signature_pad.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ink bounds', () {
    const pad = Size(400, 150);

    test('tightly bounds the strokes, with padding', () {
      final bounds = inkBounds([
        [const Offset(100, 50), const Offset(200, 90)],
      ], pad);
      // 8px of padding on each side, clipped to the pad.
      expect(bounds!.left, 92);
      expect(bounds.top, 42);
      expect(bounds.right, 208);
      expect(bounds.bottom, 98);
    });

    test('never escapes the pad', () {
      final bounds = inkBounds([
        [const Offset(2, 2), const Offset(398, 148)],
      ], pad);
      expect(bounds!.left, 0);
      expect(bounds.top, 0);
      expect(bounds.right, 400);
      expect(bounds.bottom, 150);
    });

    test('is null with nothing drawn', () {
      expect(inkBounds([], pad), isNull);
    });
  });

  group('rasterize', () {
    test('produces a PNG cropped to the ink', () async {
      final png = await rasterizeSignature([
        [const Offset(100, 50), const Offset(200, 60), const Offset(300, 50)],
      ], const Size(400, 150));
      expect(png, isNotNull);

      final decoded = img.decodePng(png!)!;
      // Cropped to the ink (~216 wide incl. padding) rather than the full pad,
      // and rendered at 3x for print.
      expect(decoded.width, lessThan(400 * 3));
      expect(decoded.width, greaterThan(200));
      expect(decoded.numChannels, 4, reason: 'must carry transparency');
    });

    test('returns null with nothing drawn', () async {
      expect(await rasterizeSignature([], const Size(400, 150)), isNull);
    });
  });

  group('imported image', () {
    /// A white page with a dark horizontal stroke across the middle.
    List<int> pageWithStroke() {
      final image = img.Image(width: 120, height: 60, numChannels: 3);
      img.fill(image, color: img.ColorRgb8(255, 255, 255));
      for (var x = 30; x < 90; x++) {
        for (var y = 28; y < 33; y++) {
          image.setPixelRgb(x, y, 20, 20, 20);
        }
      }
      return img.encodePng(image);
    }

    test('knocks out the paper and keeps the ink', () {
      final out = prepareImportedSignature(
          Uint8List.fromList(pageWithStroke()));
      expect(out, isNotNull);
      final decoded = img.decodePng(out!)!;
      expect(decoded.numChannels, 4);

      // Cropped to the stroke (60px wide + padding), not the whole 120px page.
      expect(decoded.width, lessThan(120));
      expect(decoded.width, greaterThan(50));

      // A corner is paper: fully transparent. The middle is ink: opaque.
      expect(decoded.getPixel(0, 0).a, 0);
      final centre =
          decoded.getPixel(decoded.width ~/ 2, decoded.height ~/ 2);
      expect(centre.a, greaterThan(200));
    });

    test('a blank page yields nothing rather than an empty box', () {
      final blank = img.Image(width: 50, height: 50, numChannels: 3);
      img.fill(blank, color: img.ColorRgb8(255, 255, 255));
      expect(
        prepareImportedSignature(Uint8List.fromList(img.encodePng(blank))),
        isNull,
      );
    });

    test('rejects bytes that are not an image', () {
      expect(prepareImportedSignature(Uint8List.fromList([1, 2, 3])), isNull);
    });
  });
}
