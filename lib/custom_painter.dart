import 'package:flutter/material.dart';

class DummyDrawing extends CustomPainter {
  final bool wasTabbed;
  final double xInitial;
  final double yInitial;

  DummyDrawing({
    this.wasTabbed,
    this.xInitial,
    this.yInitial,
  });

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    print('Painter: $wasTabbed');
    Paint paint = Paint();
    path.moveTo(xInitial, yInitial);
    path.lineTo(xInitial, yInitial + size.height * 0.5);
    path.lineTo(xInitial + size.width * 0.5,yInitial + size.height * 0.5);
    path.lineTo(xInitial + size.width * 0.5, yInitial);
    path.lineTo(xInitial, yInitial);
    path.close();

    paint.color = Colors.redAccent.withOpacity(wasTabbed == false ? 1 : 0.5);
    canvas.drawPath(path, paint);
//    canvas.save();
//    canvas.restore();
  }

  @override
  bool hitTest(Offset position) {
    return path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}