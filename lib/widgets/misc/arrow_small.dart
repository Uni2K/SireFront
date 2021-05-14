import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ArrowSmall extends StatelessWidget {
  ArrowSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(20, 0),
        child: Transform.rotate(
            // origin: Offset(-5, -25),
            angle: 0.5,
            child: CustomPaint(
              size: Size(40, 40),
              painter: MyPainter(),
            )));
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    path = Path();
    path.moveTo(size.width, size.height * 0.62);
    path.cubicTo(size.width * 0.94, size.height * 0.75, size.width * 0.89,
        size.height * 0.88, size.width * 0.79, size.height);
    path.cubicTo(size.width * 0.78, size.height, size.width * 0.75, size.height,
        size.width * 0.74, size.height);
    path.cubicTo(size.width * 0.67, size.height * 0.87, size.width * 0.6,
        size.height * 0.76, size.width * 0.55, size.height * 0.63);
    path.cubicTo(size.width * 0.54, size.height * 0.61, size.width * 0.58,
        size.height * 0.6, size.width * 0.6, size.height * 0.61);
    path.cubicTo(size.width * 0.64, size.height * 0.64, size.width * 0.69,
        size.height * 0.67, size.width * 0.73, size.height * 0.69);
    path.cubicTo(size.width * 0.73, size.height * 0.44, size.width * 0.74,
        size.height * 0.15, size.width * 0.31, size.height * 0.07);
    path.cubicTo(size.width * 0.11, size.height * 0.04, -0.23, -0.03,
        size.width * 0.22, size.height * 0.01);
    path.cubicTo(size.width * 0.44, size.height * 0.03, size.width * 0.63,
        size.height * 0.11, size.width * 0.72, size.height / 4);
    path.cubicTo(size.width * 0.81, size.height * 0.38, size.width * 0.8,
        size.height * 0.54, size.width * 0.8, size.height * 0.68);
    path.cubicTo(size.width * 0.85, size.height * 0.65, size.width * 0.9,
        size.height * 0.62, size.width * 0.95, size.height * 0.6);
    path.cubicTo(size.width * 0.98, size.height * 0.59, size.width,
        size.height * 0.6, size.width, size.height * 0.62);
    path.cubicTo(size.width, size.height * 0.62, size.width, size.height * 0.62,
        size.width, size.height * 0.62);
    path.lineTo(size.width * 0.77, size.height * 0.74);
    path.cubicTo(size.width * 0.76, size.height * 0.74, size.width * 0.75,
        size.height * 0.74, size.width * 0.74, size.height * 0.73);
    path.cubicTo(size.width * 0.74, size.height * 0.73, size.width * 0.74,
        size.height * 0.72, size.width * 0.74, size.height * 0.72);
    path.cubicTo(size.width * 0.71, size.height * 0.72, size.width * 0.67,
        size.height * 0.7, size.width * 0.64, size.height * 0.69);
    path.cubicTo(size.width * 0.68, size.height * 0.77, size.width * 0.72,
        size.height * 0.85, size.width * 0.77, size.height * 0.93);
    path.cubicTo(size.width * 0.83, size.height * 0.85, size.width * 0.87,
        size.height * 0.76, size.width * 0.91, size.height * 0.67);
    path.cubicTo(size.width * 0.87, size.height * 0.7, size.width * 0.82,
        size.height * 0.72, size.width * 0.77, size.height * 0.74);
    path.cubicTo(size.width * 0.77, size.height * 0.74, size.width * 0.77,
        size.height * 0.74, size.width * 0.77, size.height * 0.74);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
