import 'package:flutter/material.dart';

class RoadSeparatorPainter extends CustomPainter {
  final double dashHeight;
  final double dashGap;
  final double strokeWidth;
  final Color color;

  RoadSeparatorPainter({
    this.dashHeight = 4.0,
    this.dashGap = 4.0,
    this.strokeWidth = 0.5,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double leftLineX = centerX - size.width / 6; // Left separator
    final double rightLineX = centerX + size.width / 6; // Right separator
    // Draw left dashed line
    _drawDashedLine(
      canvas,
      paint,
      Offset(leftLineX, 0),
      Offset(leftLineX, size.height),
    );

    // Draw right dashed line
    _drawDashedLine(
      canvas,
      paint,
      Offset(rightLineX, 0),
      Offset(rightLineX, size.height),
    );
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    double currentY = start.dy;
    final double endY = end.dy;
    final double x = start.dx;

    while (currentY < endY) {
      canvas.drawLine(
        Offset(x, currentY),
        Offset(x, currentY + dashHeight),
        paint,
      );
      currentY += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
