import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ArrowDefault extends StatelessWidget {
  ArrowDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text("Direkt hier\nbearbeiten", style: TextStyle(color: primaryColor, fontSize: 20),),

        Transform.rotate(
          origin: Offset(-5,-25),
          angle: 2.3,
          child: CustomPaint(
            size: Size(60,60),
            painter: MyPainter(),
          )),],)
    );
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
    path.moveTo(size.width * 1.68, size.height * 0.48);
    path.cubicTo(size.width * 1.62, size.height * 0.35, size.width * 1.57,
        size.height * 0.23, size.width * 1.47, size.height * 0.11);
    path.cubicTo(size.width * 1.46, size.height * 0.1, size.width * 1.43,
        size.height * 0.1, size.width * 1.42, size.height * 0.11);
    path.cubicTo(size.width * 1.35, size.height * 0.23, size.width * 1.27,
        size.height * 0.35, size.width * 1.23, size.height * 0.47);
    path.cubicTo(size.width * 1.22, size.height * 0.48, size.width * 1.24,
        size.height / 2, size.width * 1.27, size.height * 0.49);
    path.cubicTo(size.width * 1.27, size.height * 0.49, size.width * 1.27,
        size.height * 0.49, size.width * 1.28, size.height * 0.49);
    path.cubicTo(size.width * 1.32, size.height * 0.46, size.width * 1.36,
        size.height * 0.43, size.width * 1.41, size.height * 0.41);
    path.cubicTo(size.width * 1.41, size.height * 0.66, size.width * 1.42,
        size.height * 0.95, size.width * 0.98, size.height * 1.03);
    path.cubicTo(size.width * 0.79, size.height * 1.07, size.width * 0.45,
        size.height * 1.13, size.width * 0.9, size.height * 1.09);
    path.cubicTo(size.width * 1.12, size.height * 1.07, size.width * 1.31,
        size.height, size.width * 1.4, size.height * 0.85);
    path.cubicTo(size.width * 1.48, size.height * 0.72, size.width * 1.48,
        size.height * 0.57, size.width * 1.47, size.height * 0.43);
    path.cubicTo(size.width * 1.52, size.height * 0.45, size.width * 1.57,
        size.height * 0.48, size.width * 1.63, size.height / 2);
    path.cubicTo(size.width * 1.65, size.height * 0.51, size.width * 1.69,
        size.height / 2, size.width * 1.68, size.height * 0.48);
    path.cubicTo(size.width * 1.68, size.height * 0.48, size.width * 1.68,
        size.height * 0.48, size.width * 1.68, size.height * 0.48);
    path.lineTo(size.width * 1.45, size.height * 0.37);
    path.cubicTo(size.width * 1.44, size.height * 0.36, size.width * 1.43,
        size.height * 0.37, size.width * 1.42, size.height * 0.38);
    path.cubicTo(size.width * 1.42, size.height * 0.38, size.width * 1.42,
        size.height * 0.38, size.width * 1.42, size.height * 0.38);
    path.cubicTo(size.width * 1.38, size.height * 0.39, size.width * 1.35,
        size.height * 0.4, size.width * 1.31, size.height * 0.42);
    path.cubicTo(size.width * 1.35, size.height / 3, size.width * 1.4,
        size.height / 4, size.width * 1.45, size.height * 0.17);
    path.cubicTo(size.width * 1.51, size.height / 4, size.width * 1.55,
        size.height * 0.34, size.width * 1.59, size.height * 0.43);
    path.cubicTo(size.width * 1.55, size.height * 0.41, size.width * 1.5,
        size.height * 0.38, size.width * 1.45, size.height * 0.37);
    path.cubicTo(size.width * 1.45, size.height * 0.37, size.width * 1.45,
        size.height * 0.37, size.width * 1.45, size.height * 0.37);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
