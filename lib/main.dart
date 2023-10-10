import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tearable_cloth/cloth.dart';
import 'package:flutter_tearable_cloth/cloth_painter.dart';
import 'package:flutter_tearable_cloth/settings.dart';
import 'package:flutter_tearable_cloth/mouse.dart';

Mouse mouse = Mouse();

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Cloth cloth = Cloth();

  @override
  void initState() {
    super.initState();

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
                  onPointerDown: (PointerDownEvent event) {
                    mouse.mouseDown = true;
                    mouse.isLeftButton = event.buttons == kPrimaryMouseButton;
                  },
                  onPointerUp: (PointerUpEvent event) {
                    mouse.mouseDown = false;
                    mouse.isLeftButton = false;
                  },
                  onPointerMove: (PointerMoveEvent event) {
                    mouse.previousX = mouse.x;
                    mouse.previousY = mouse.y;

                    mouse.x = event.localPosition.dx;
                    mouse.y = event.localPosition.dy;
                  },
                  onPointerHover: (PointerHoverEvent event) {
                    mouse.previousX = mouse.x;
                    mouse.previousY = mouse.y;

                    mouse.x = event.localPosition.dx;
                    mouse.y = event.localPosition.dy;
                  },
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
}
