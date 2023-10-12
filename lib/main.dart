import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tearable_cloth/cloth.dart';
import 'package:flutter_tearable_cloth/cloth_painter.dart';
import 'package:flutter_tearable_cloth/pointer.dart';
import 'package:flutter_tearable_cloth/settings.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Pointer pointer = Pointer();

  late final Cloth cloth;

  @override
  void initState() {
    super.initState();

    cloth = Cloth(pointer);

    Timer.periodic(
      const Duration(milliseconds: 16),
      (Timer timer) => setState(() => cloth.update()),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '- Drag to move the cloth.\n- Right click and drag to tear the cloth.',
                  style: TextStyle(fontSize: 16),
                ),
                Listener(
                  onPointerDown: _handlePointerDown,
                  onPointerUp: _handlePointerUp,
                  onPointerMove: _handlePointerMove,
                  onPointerHover: _handlePointerHover,
                  child: CustomPaint(
                    size: const Size(canvasWidth, canvasHeight),
                    painter: ClothPainter(
                      cloth: cloth,
                      showHeatmap: false,
                      pointMode: PointMode.polygon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _handlePointerDown(PointerDownEvent event) {
    pointer.pressed = true;
    pointer.isActionPressed = event.buttons == kPrimaryMouseButton;
  }

  void _handlePointerUp(PointerUpEvent event) {
    pointer.pressed = false;
    pointer.isActionPressed = false;
  }

  void _handlePointerMove(PointerMoveEvent event) {
    pointer.previousPosition = pointer.position;
    pointer.position = event.localPosition;
  }

  void _handlePointerHover(PointerHoverEvent event) {
    pointer.previousPosition = pointer.position;
    pointer.position = event.localPosition;
  }
}
