
import 'package:flutter/material.dart';

class CustomCircleThumb extends SliderComponentShape {
   CustomCircleThumb();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(24, 24);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // Outer Orange Circle
    final Paint outerPaint = Paint()..color = const Color(0xFFF9B039);
    canvas.drawCircle(center, 12, outerPaint);

    // Inner Blue Circle
    final Paint innerPaint = Paint()..color = const Color(0xFFB3E5FC);
    canvas.drawCircle(center, 8, innerPaint);
  }
}