import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_tearable_cloth/cloth.dart';

class ClothPainter extends CustomPainter {
  ClothPainter({
    required this.cloth,
    required this.showHeatmap,
    required this.pointMode,
  });

  final Cloth cloth;
  final bool showHeatmap;
  final PointMode pointMode;

  @override
  void paint(Canvas canvas, Size size) => cloth.draw(
        canvas: canvas,
        paint: Paint()
          ..color = Colors.black
          ..strokeWidth = 2,
        showHeatmap: showHeatmap,
        pointMode: pointMode,
      );

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
