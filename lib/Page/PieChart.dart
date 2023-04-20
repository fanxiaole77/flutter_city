import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PieChart extends StatelessWidget {
  final double width;
  final double height;
  final double percentage;
  final Color color1;
  final Color color2;
  final double strokeWidth;

  const PieChart({
    Key? key,
    required this.width,
    required this.height,
    required this.percentage,
    required this.color1,
    required this.color2,
    this.strokeWidth = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _PieChartPainter(
        percentage: percentage,
        color1: color1,
        color2: color2,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double percentage;
  final Color color1;
  final Color color2;
  final double strokeWidth;

  _PieChartPainter({
    required this.percentage,
    required this.color1,
    required this.color2,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY) - strokeWidth / 2;

    Paint paint1 = Paint()
      ..color = color1
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint paint2 = Paint()
      ..color = color2
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    double arcAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(rect, -pi / 2, arcAngle, false, paint1);

    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: radius / 4),
      text: '${percentage.round()}%',
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, Offset(centerX - tp.width / 2, centerY - tp.height / 2));

    canvas.drawArc(rect, arcAngle - pi / 2, 2 * pi - arcAngle, false, paint2);
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) {
    return percentage != oldDelegate.percentage ||
        color1 != oldDelegate.color1 ||
        color2 != oldDelegate.color2 ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
