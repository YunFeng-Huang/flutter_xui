import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class XDottedLine extends StatelessWidget {
  late  double height;
  late Color color;
  late double dotSize;
  late double space;

  XDottedLine({
    this.height = 100.0,
    this.color = Colors.black,
    this.dotSize = 4.0,
    this.space = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
        color: color,
        dotSize: dotSize,
        space: space,
      ),
      size: Size(dotSize, height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double space;

  _DottedLinePainter({
    this.color = Colors.black,
    this.dotSize = 4.0,
    this.space = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dotSize
      ..strokeCap = StrokeCap.round;

    double startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0.0, startY),
        Offset(0.0, startY + dotSize),
        paint,
      );
      startY += dotSize + space;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldPainter) => false;
}
