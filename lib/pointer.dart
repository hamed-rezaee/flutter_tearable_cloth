import 'package:flutter/material.dart';

class Pointer {
  bool pressed = false;
  bool isActionPressed = false;

  Offset position = Offset.zero;
  Offset previousPosition = Offset.zero;
}
