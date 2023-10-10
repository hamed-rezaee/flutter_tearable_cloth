import 'dart:math';
import 'dart:ui';

import 'package:flutter_tearable_cloth/settings.dart';
import 'package:flutter_tearable_cloth/point.dart';

class Constraint {
  Constraint(this.p1, this.p2, [this.length = spacing]);

  Point p1, p2;
  double length;

  void resolve() {
    final double diffX = p1.x - p2.x;
    final double diffY = p1.y - p2.y;
    final double dist = sqrt(diffX * diffX + diffY * diffY);
    final double diff = (length - dist) / dist;

    if (dist > tearDistance) {
      p1.removeConstraint(this);
    }

    final double px = diffX * diff * 0.5;
    final double py = diffY * diff * 0.5;

    p1.x += px;
    p1.y += py;
    p2.x -= px;
    p2.y -= py;
  }

  void draw(Canvas canvas, Paint paint, PointMode pointMode) {
    canvas.drawPoints(
      pointMode,
      <Offset>[Offset(p1.x, p1.y), Offset(p2.x, p2.y)],
      paint,
    );
  }
}
