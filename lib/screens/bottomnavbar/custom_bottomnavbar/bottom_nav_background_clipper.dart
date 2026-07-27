import 'package:flutter/material.dart';

Path _topBorderPath({
  required Size size,
  required double barTop,
  required double cornerRadius,
  required double curveHalfWidth,
}) {
  final double centerX = size.width / 2;
  final double curveStart = centerX - curveHalfWidth;
  final double curveEnd = centerX + curveHalfWidth;

  return Path()
    ..moveTo(0, barTop + cornerRadius)
    ..quadraticBezierTo(0, barTop, cornerRadius, barTop)
    ..lineTo(curveStart, barTop)
    ..cubicTo(
      centerX - (curveHalfWidth * .55),
      barTop,
      centerX - (curveHalfWidth * .55),
      0,
      centerX,
      0,
    )
    ..cubicTo(
      centerX + (curveHalfWidth * .55),
      0,
      centerX + (curveHalfWidth * .55),
      barTop,
      curveEnd,
      barTop,
    )
    ..lineTo(size.width - cornerRadius, barTop)
    ..quadraticBezierTo(size.width, barTop, size.width, barTop + cornerRadius);
}

class BottomNavBackgroundClipper extends CustomClipper<Path> {
  final double barTop;
  final double cornerRadius;
  final double curveHalfWidth;

  const BottomNavBackgroundClipper({
    required this.barTop,
    required this.cornerRadius,
    required this.curveHalfWidth,
  });

  @override
  Path getClip(Size size) {
    return _topBorderPath(
        size: size,
        barTop: barTop,
        cornerRadius: cornerRadius,
        curveHalfWidth: curveHalfWidth,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(BottomNavBackgroundClipper oldClipper) {
    return barTop != oldClipper.barTop ||
        cornerRadius != oldClipper.cornerRadius ||
        curveHalfWidth != oldClipper.curveHalfWidth;
  }
}

class BottomNavTopBorderPainter extends CustomPainter {
  final double barTop;
  final double cornerRadius;
  final double curveHalfWidth;
  final Color color;
  final double strokeWidth;

  const BottomNavTopBorderPainter({
    required this.barTop,
    required this.cornerRadius,
    required this.curveHalfWidth,
    required this.color,
    this.strokeWidth = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    canvas.drawPath(
      _topBorderPath(
        size: size,
        barTop: barTop,
        cornerRadius: cornerRadius,
        curveHalfWidth: curveHalfWidth,
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(BottomNavTopBorderPainter oldDelegate) {
    return barTop != oldDelegate.barTop ||
        cornerRadius != oldDelegate.cornerRadius ||
        curveHalfWidth != oldDelegate.curveHalfWidth ||
        color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
