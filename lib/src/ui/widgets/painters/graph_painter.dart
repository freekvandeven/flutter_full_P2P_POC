import 'dart:math';

import 'package:flutter/material.dart';

class GraphPainter extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomDecorationPainter();
  }
}

class _CustomDecorationPainter extends BoxPainter {
  // https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var paint = Paint()
      ..color = Color(0xFFb1b8bc)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;
    var height = configuration.size!.height.toInt();
    var width = configuration.size!.width.toInt();
    // get a random location
    var random = Random();

    var path = Path();
    var startPoint = random.nextInt(height).toDouble();
    double endPoint;
    for (var i = 0; i < width; i += 100) {
      endPoint = random.nextInt(height).toDouble();
      path
        ..moveTo(i.toDouble(), startPoint)
        ..quadraticBezierTo(
          i + 50,
          height.toDouble(),
          min(i + 100, width.toDouble()),
          endPoint,
        );
      startPoint = endPoint;
    }
    canvas.drawPath(path, paint);
  }
}
