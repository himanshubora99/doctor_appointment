import 'package:appointment_booking/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;
  final Color color;

  const DottedDivider(
      {Key? key,
      this.strokeWidth = 1.0,
      this.dashWidth = 2.0,
      this.gapWidth = 2.0,
      this.color = AppColors.customGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: CustomPaint(
        painter: DottedLinePainter(
          strokeWidth: strokeWidth,
          dashWidth: dashWidth,
          gapWidth: gapWidth,
          color: color,
        ),
        child: Container(
          height: strokeWidth,
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;
  final Color color;

  DottedLinePainter(
      {required this.strokeWidth,
      required this.dashWidth,
      required this.gapWidth,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final double dashWidth = gapWidth;
    final double dashSpace = dashWidth;

    double startY = 0.0;
    // double endY = size.height;
    double currentX = 0.0;
    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(currentX + dashWidth, startY),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
