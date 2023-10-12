import 'dart:ui';

import 'package:flutter_tearable_cloth/constraint.dart';
import 'package:flutter_tearable_cloth/pointer.dart';
import 'package:flutter_tearable_cloth/settings.dart';

class Point {
  Point(this.position, this.pointer) {
    pointerPosition = position;
  }

  final Pointer pointer;

  Offset position;

  Offset pointerPosition = Offset.zero;
  Offset velocity = Offset.zero;
  Offset? pinPosition;

  List<Constraint> constraints = <Constraint>[];

  void update(double delta) {
    if (pointer.pressed) {
      final Offset difference = position - pointer.position;
      final double distance = difference.distance;

      if (pointer.isActionPressed) {
        if (distance < mouseInfluence) {
          pointerPosition =
              position - (pointer.position - pointer.previousPosition);
        }
      } else if (distance < mouseCut) {
        constraints.clear();
      }
    }

    addForce(const Offset(0, gravity));

    Offset nextPosition = position +
        ((position - pointerPosition) * friction) +
        (velocity * 0.5 * delta * delta);

    pointerPosition = position;
    position = nextPosition;

    velocity = Offset.zero;
  }

  void draw(Canvas canvas, Paint paint, PointMode pointMode) {
    if (constraints.isEmpty) {
      return;
    }

    for (int i = 0; i < constraints.length; i++) {
      constraints[i].draw(canvas, paint, pointMode);
    }
  }

  void resolveConstraints() {
    if (pinPosition != null) {
      position = pinPosition!;

      return;
    }

    int i = constraints.length;

    while (i-- > 0) {
      constraints[i].resolve();
    }

    double x = position.dx;
    double y = position.dy;

    if (x > canvasWidth - 1) {
      x = 2 * (canvasWidth - 1) - x;
    } else if (x < 1) {
      x = 2 - x;
    }

    if (y < 1) {
      y = 2 - y;
    } else if (y > canvasHeight - 1) {
      y = 2 * (canvasHeight - 1) - y;
    }

    position = Offset(x, y);
  }

  void attach(Point point) => constraints.add(Constraint(this, point));

  void removeConstraint(Constraint constraint) {
    final int index = constraints.indexOf(constraint);

    constraints.removeAt(index);
  }

  void addForce(Offset force) => velocity += force;
}
