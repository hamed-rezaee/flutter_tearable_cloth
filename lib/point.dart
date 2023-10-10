import 'dart:math';
import 'dart:ui';

import 'package:flutter_tearable_cloth/settings.dart';
import 'package:flutter_tearable_cloth/constraint.dart';
import 'package:flutter_tearable_cloth/main.dart';

class Point {
  Point(this.x, this.y) {
    pointerX = x;
    pointerY = y;
  }

  double x;
  double y;

  double pointerX = 0;
  double pointerY = 0;
  double velocityX = 0;
  double velocityY = 0;
  double? pinX;
  double? pinY;

  List<Constraint> constraints = <Constraint>[];

  void update(double delta) {
    if (mouse.mouseDown) {
      final double diffX = x - mouse.x;
      final double diffY = y - mouse.y;
      final double dist = sqrt(diffX * diffX + diffY * diffY);

      if (mouse.isLeftButton) {
        if (dist < mouseInfluence) {
          pointerX = x - (mouse.x - mouse.previousX);
          pointerY = y - (mouse.y - mouse.previousY);
        }
      } else if (dist < mouseCut) {
        constraints.clear();
      }
    }

    addForce(0, gravity);

    final double nextX =
        x + ((x - pointerX) * friction) + ((velocityX / 2) * delta * delta);
    final double nextY =
        y + ((y - pointerY) * friction) + ((velocityY / 2) * delta * delta);

    pointerX = x;
    pointerY = y;

    x = nextX;
    y = nextY;

    velocityY = 0;
    velocityX = 0;
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
    if (pinX != null && pinY != null) {
      x = pinX!;
      y = pinY!;

      return;
    }

    int i = constraints.length;

    while (i-- > 0) {
      constraints[i].resolve();
    }

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
  }

  void attach(Point point) => constraints.add(Constraint(this, point));

  void removeConstraint(Constraint constraint) {
    final int index = constraints.indexOf(constraint);

    constraints.removeAt(index);
  }

  void addForce(double x, double y) {
    velocityX += x;
    velocityY += y;
  }
}
