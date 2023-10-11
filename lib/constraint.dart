import 'dart:ui';

import 'package:flutter_tearable_cloth/settings.dart';
import 'package:flutter_tearable_cloth/point.dart';

class Constraint {
  Constraint(this.p1, this.p2, [this.length = spacing]);

  Point p1, p2;
  double length;

  void resolve() {
    final Offset difference = p1.position - p2.position;
    final double distance = difference.distance;
    final double distanceRatio = (length - distance) / distance;

    if (distance > tearDistance) {
      p1.removeConstraint(this);
    }

    final Offset offset = difference * distanceRatio * 0.5;

    p1.position += offset;
    p2.position -= offset;
  }

  void draw(Canvas canvas, Paint paint, PointMode pointMode) =>
      canvas.drawPoints(pointMode, <Offset>[p1.position, p2.position], paint);
}
