import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_tearable_cloth/point.dart';
import 'package:flutter_tearable_cloth/settings.dart';

class Cloth {
  Cloth() {
    for (int y = 0; y <= clothHeight; y++) {
      for (int x = 0; x <= clothWidth; x++) {
        final Point point = Point(startX + x * spacing, startY + y * spacing);

        if (x != 0) {
          point.attach(_points[_points.length - 1]);
        }

        if (y == 0) {
          point.pinX = point.x;
          point.pinY = point.y;
        }

        if (y != 0) {
          point.attach(_points[(x + (y - 1) * (clothWidth + 1)).floor()]);
        }

        _points.add(point);
      }
    }
  }

  final List<Point> _points = <Point>[];

  void update() {
    int i = physicsAccuracy;

    while (i-- > 0) {
      int j = _points.length;

      while (j-- > 0) {
        _points[j].resolveConstraints();
      }
    }

    i = _points.length;

    while (i-- > 0) {
      _points[i].update(0.016);
    }
  }

  void draw({
    required Canvas canvas,
    required Paint paint,
    required bool showHeatmap,
    required PointMode pointMode,
  }) {
    int i = _points.length;

    final List<bool> pattern = <bool>[
      true,
      false,
      true,
      true,
      false,
      true,
      true,
      false,
      false,
      false,
      true,
    ];

    final double minDist = _getMinPointsDistance(_points);
    final double maxDist = _getMaxPointsDistance(_points);

    while (i-- > 0) {
      if (showHeatmap) {
        paint.color = _getHeatmapColor(i, minDist, maxDist, paint);
      } else {
        if (pattern[i % pattern.length] == true) {
          paint.color = Colors.white;
        } else if (pattern[i % pattern.length] == false) {
          paint.color = Colors.green;
        }
      }

      _points[i].draw(canvas, paint, pointMode);
    }
  }

  Color _getHeatmapColor(int i, double minDist, double maxDist, Paint paint) {
    final double diffX = _points[i].x - _points[i].pointerX;
    final double diffY = _points[i].y - _points[i].pointerY;
    final double dist = sqrt(diffX * diffX + diffY * diffY);

    final double value = _mapValue(dist, minDist, maxDist, 0, 1);

    return HSVColor.fromAHSV(1, 240 * value, 1, 1).toColor();
  }

  double _mapValue(
    double value,
    double min,
    double max,
    double newMin,
    double newMax,
  ) =>
      ((value - min) / (max - min + 0.1)) * (newMax - newMin) + newMin;

  double clamp(double value, double min, double max) {
    if (value < min) {
      return min;
    }

    if (value > max) {
      return max;
    }

    return value;
  }

  double _getMaxPointsDistance(List<Point> points) {
    double max = 0;

    for (int i = 0; i < points.length; i++) {
      final double diffX = points[i].x - points[i].pointerX;
      final double diffY = points[i].y - points[i].pointerY;
      final double dist = sqrt(diffX * diffX + diffY * diffY);

      if (dist > max) {
        max = dist;
      }
    }

    return max;
  }

  double _getMinPointsDistance(List<Point> points) {
    double min = double.infinity;

    for (int i = 0; i < points.length; i++) {
      final double diffX = points[i].x - points[i].pointerX;
      final double diffY = points[i].y - points[i].pointerY;
      final double dist = sqrt(diffX * diffX + diffY * diffY);

      if (dist < min) {
        min = dist;
      }
    }

    return min;
  }
}
