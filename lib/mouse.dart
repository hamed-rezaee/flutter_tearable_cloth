import 'package:flutter/material.dart';

class Mouse {
  bool mouseDown = false;
  bool isLeftButton = false;

  Offset position = Offset.zero;
  Offset previousPosition = Offset.zero;
}
