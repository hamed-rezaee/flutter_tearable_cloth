import 'package:flutter/material.dart';

const double canvasWidth = 800;
const double canvasHeight = 600;
const double clothWidth = 80;
const double clothHeight = 60;

const double gravity = 1200;
const int physicsAccuracy = 3;
const double friction = 0.98;

const double spacing = 5;
const double tearDistance = 50;

const Offset start =
    Offset(canvasWidth * 0.5 - (clothWidth * spacing) * 0.5, 20);

const double pointerInfluence = 40;
const double pointerCut = 7;
