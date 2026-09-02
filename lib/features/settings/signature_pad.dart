import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// Resolution multiplier applied when rasterising a drawn signature. The pad is
/// laid out in logical pixels but the PNG is stamped into a PDF, so it is
/// recorded larger to stay crisp in print.
const double _exportScale = 3.0;

/// Padding kept around the ink when trimming, in logical pixels.
const double _trimPadding = 8.0;

/// One continuous pen stroke.
typedef Stroke = List<Offset>;

/// A draw-your-signature surface, as in a PDF viewer's signing tool: draw with
/// a finger, trackpad or mouse, undo a stroke you don't like, and save.
///
/// Returns a transparent PNG cropped to the ink, or null if cancelled.
class SignaturePadDialog extends StatefulWidget {
  const SignaturePadDialog({super.key});

  static Future<Uint8List?> show(BuildContext context) =>
      showDialog<Uint8List>(
        context: context,
        builder: (_) => const SignaturePadDialog(),
      );

  @override
  State<SignaturePadDialog> createState() => _SignaturePadDialogState();
}

class _SignaturePadDialogState extends State<SignaturePadDialog> {
  final List<Stroke> _strokes = [];
  final _padKey = GlobalKey();

  bool get _hasInk => _strokes.any((s) => s.length > 1);

  void _start(Offset p) => setState(() => _strokes.add([p]));
  void _extend(Offset p) => setState(() => _strokes.last.add(p));

  void _undo() => setState(() {
        if (_strokes.isNotEmpty) _strokes.removeLast();
      });

  void _clear() => setState(_strokes.clear);

  Future<void> _save() async {
    final size = _padKey.currentContext?.size;
    if (size == null || !_hasInk) return;
    final png = await rasterizeSignature(_strokes, size);
    if (mounted) Navigator.of(context).pop(png);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: const Text('Draw your signature'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign as you would on paper. Only the ink is kept — the '
              'surrounding space is trimmed off.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            // A fixed aspect keeps the drawn shape consistent between the
            // phone and the desktop, so a signature drawn on one looks the
            // same when stamped from the other.
            AspectRatio(
              aspectRatio: 2.6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  border: Border.all(color: scheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onPanStart: (d) => _start(d.localPosition),
                  onPanUpdate: (d) => _extend(d.localPosition),
                  child: CustomPaint(
                    key: _padKey,
                    painter: _SignaturePainter(_strokes, scheme.onSurface),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _strokes.isEmpty ? null : _undo,
          child: const Text('Undo'),
        ),
        TextButton(
          onPressed: _strokes.isEmpty ? null : _clear,
          child: const Text('Clear'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _hasInk ? _save : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _SignaturePainter extends CustomPainter {
  const _SignaturePainter(this.strokes, this.color);
  final List<Stroke> strokes;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) => paintStrokes(canvas, strokes, color);

  @override
  bool shouldRepaint(_SignaturePainter old) => true;
}

/// Draws [strokes] onto [canvas]. Shared by the live pad and the rasteriser so
/// what you save is exactly what you drew.
void paintStrokes(Canvas canvas, List<Stroke> strokes, Color color,
    {double width = 2.6}) {
  final paint = Paint()
    ..color = color
    ..strokeWidth = width
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
  for (final stroke in strokes) {
    if (stroke.length == 1) {
      // A tap is a dot — a full stop or an i's dot has to survive.
      canvas.drawCircle(stroke.first, width / 2, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
      continue;
    }
    final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
    for (var i = 1; i < stroke.length; i++) {
      path.lineTo(stroke[i].dx, stroke[i].dy);
    }
    canvas.drawPath(path, paint);
  }
}

/// The tight bounds of [strokes], grown by [_trimPadding] and clipped to
/// [bounds]. Returns null when there is nothing drawn.
Rect? inkBounds(List<Stroke> strokes, Size bounds) {
  double? minX, minY, maxX, maxY;
  for (final stroke in strokes) {
    for (final p in stroke) {
      minX = minX == null ? p.dx : math.min(minX, p.dx);
      minY = minY == null ? p.dy : math.min(minY, p.dy);
      maxX = maxX == null ? p.dx : math.max(maxX, p.dx);
      maxY = maxY == null ? p.dy : math.max(maxY, p.dy);
    }
  }
  if (minX == null) return null;
  final rect = Rect.fromLTRB(
    minX - _trimPadding,
    minY! - _trimPadding,
    maxX! + _trimPadding,
    maxY! + _trimPadding,
  );
  return rect.intersect(Offset.zero & bounds);
}

/// Rasterises [strokes] drawn on a pad of [padSize] into a transparent PNG,
/// cropped to the ink. Black, because a signature is stamped onto white paper —
/// the pad's on-surface colour is only for drawing against the app's theme.
Future<Uint8List?> rasterizeSignature(
    List<Stroke> strokes, Size padSize) async {
  final crop = inkBounds(strokes, padSize);
  if (crop == null || crop.isEmpty) return null;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.scale(_exportScale);
  canvas.translate(-crop.left, -crop.top);
  paintStrokes(canvas, strokes, const Color(0xFF000000));

  final picture = recorder.endRecording();
  final image = await picture.toImage(
    (crop.width * _exportScale).ceil(),
    (crop.height * _exportScale).ceil(),
  );
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  picture.dispose();
  image.dispose();
  return data?.buffer.asUint8List();
}

/// Lets the user pick a photographed or scanned signature and prepares it for
/// stamping: downscaled, and with its paper background knocked out so it does
/// not sit on the invoice as a white block over the ruled line.
Future<Uint8List?> importSignatureImage() async {
  final file = await fs.openFile(acceptedTypeGroups: const [
    fs.XTypeGroup(
      label: 'Images',
      extensions: ['png', 'jpg', 'jpeg', 'webp'],
    ),
  ]);
  if (file == null) return null;
  return prepareImportedSignature(await file.readAsBytes());
}

/// Longest edge kept for an imported signature.
const int _importMaxDim = 900;

/// Pixels at least this bright are treated as paper and made transparent.
const int _paperThreshold = 190;

/// Turns a photographed signature into a transparent PNG: paper drops out,
/// ink stays, and the result is cropped to what's left. Exposed for testing.
Uint8List? prepareImportedSignature(Uint8List bytes) {
  // decodeImage probes each format in turn and throws — rather than returning
  // null — when handed bytes that aren't an image at all, so a corrupt or
  // mis-typed file must not escape as a crash.
  final img.Image? decoded;
  try {
    decoded = img.decodeImage(bytes);
  } catch (_) {
    return null;
  }
  if (decoded == null) return null;

  final scaled = decoded.width > _importMaxDim || decoded.height > _importMaxDim
      ? img.copyResize(
          decoded,
          width: decoded.width >= decoded.height ? _importMaxDim : null,
          height: decoded.height > decoded.width ? _importMaxDim : null,
        )
      : decoded;

  final out = scaled.convert(numChannels: 4);
  var minX = out.width, minY = out.height, maxX = -1, maxY = -1;
  for (final p in out) {
    // Luminance, not a single channel: blue ink on white paper must survive.
    final lum = img.getLuminance(p);
    if (lum >= _paperThreshold) {
      p.a = 0;
    } else {
      // Darker ink stays more opaque; the mid-tones feather the edges so the
      // stroke doesn't come out jagged.
      p.a = 255 - ((lum / _paperThreshold) * 255).round().clamp(0, 255);
      p
        ..r = 0
        ..g = 0
        ..b = 0;
      if (p.x < minX) minX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.x > maxX) maxX = p.x;
      if (p.y > maxY) maxY = p.y;
    }
  }
  if (maxX < 0) return null; // Nothing but paper.

  const pad = 6;
  final x = math.max(0, minX - pad);
  final y = math.max(0, minY - pad);
  final cropped = img.copyCrop(
    out,
    x: x,
    y: y,
    width: math.min(out.width - x, maxX - minX + 1 + pad * 2),
    height: math.min(out.height - y, maxY - minY + 1 + pad * 2),
  );
  return img.encodePng(cropped);
}
