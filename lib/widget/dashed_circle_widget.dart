import 'dart:math';

import 'package:flutter/cupertino.dart';

class DashedCircleBorder extends StatelessWidget {
  final double borderWidth;
  final Color borderColor;

  const DashedCircleBorder({
    required this.borderWidth,
    required this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromWidth(borderWidth),
      painter: DashedCirclePainter(
        borderColor: borderColor,
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color borderColor;
  DashedCirclePainter({
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    const double dashWidth = 3;
    const double dashSpace = 3;

    Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    double step = radians(dashSpace);
    Path dashPath = Path();
    for (double i = 0; i < 360; i += dashWidth + dashSpace) {
      double from = radians(i);
      dashPath.arcTo(
          Rect.fromCircle(center: size.center(Offset.zero), radius: radius), from, step, true);
    }

    canvas.drawPath(dashPath, borderPaint);
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
