# Flutter Cloth Simulation

This documentation provides an overview of the classes and their roles, each class plays a crucial role in achieving the interactive and dynamic cloth behavior. Use this documentation as a reference to understand the structure and purpose of each component in the project.

![Cloth Simulation](/flutter_tearable_cloth.gif)

## Table of Contents

1. [ClothPainter Class](#clothpainter-class)
2. [Cloth Class](#cloth-class)
3. [Point Class](#point-class)
4. [Constraint Class](#constraint-class)
5. [Pointer Class](#pointer-class)
6. [Settings](#settings)

## ClothPainter Class

The `ClothPainter` class is responsible for painting the cloth on the canvas.

### Attributes

- `cloth`: An instance of the `Cloth` class representing the cloth.
- `showHeatmap`: A boolean value indicating whether to display a heatmap effect.
- `pointMode`: A `PointMode` enum value representing the point drawing mode.

### Methods

- `paint(Canvas canvas, Size size)`: Paints the cloth on the canvas.
- `shouldRepaint(CustomPainter oldDelegate)`: Determines if a repaint is required.

## Cloth Class

The `Cloth` class represents the cloth and is responsible for its creation and simulation.

### Attributes

- `_points`: A list of `Point` objects representing the cloth's points.

### Methods

- `update()`: Updates the cloth's simulation.
- `draw(Canvas canvas, Paint paint, bool showHeatmap, PointMode pointMode)`: Draws the cloth on the canvas.
- Other helper methods to handle cloth simulation.

## Point Class

The `Point` class represents a point in the cloth and handles its behavior.

### Attributes

- `position`: The position of the point.
- `pointer`: An instance of the `Pointer` class representing user interaction.
- `velocity`: The velocity of the point.
- `pinPosition`: The position at which the point is pinned.

### Methods

- `update(double delta)`: Updates the point's position.
- `draw(Canvas canvas, Paint paint, PointMode pointMode)`: Draws the point on the canvas.
- `resolveConstraints()`: Resolves constraints related to the point.
- Other methods for point behavior.

## Constraint Class

The `Constraint` class defines a constraint between two points in the cloth.

### Attributes

- `p1`: The first `Point` involved in the constraint.
- `p2`: The second `Point` involved in the constraint.
- `length`: The desired length of the constraint.

### Methods

- `resolve()`: Resolves the constraint to maintain the desired length.
- `draw(Canvas canvas, Paint paint, PointMode pointMode)`: Draws the constraint on the canvas.

## Pointer Class

The `Pointer` class represents user interaction with the cloth.

### Attributes

- `pressed`: A boolean indicating if the pointer is pressed.
- `isActionPressed`: A boolean indicating if the pointer is in an action (e.g., tearing the cloth).
- `position`: The current position of the pointer.
- `previousPosition`: The previous position of the pointer.

## Settings

The `Settings` class defines constants and settings for the cloth simulation.

```dart
const double canvasWidth = 800;
const double canvasHeight = 600;
const double clothWidth = 80;
const double clothHeight = 60;

const double gravity = 1200;
const int physicsAccuracy = 3;
const double friction = 0.98;

const double spacing = 5;
const double tearDistance = 50;
const Offset start = Offset(canvasWidth * 0.5 - (clothWidth * spacing) * 0.5, 20);

const double mouseInfluence = 40;
const double mouseCut = 7;
```

## Inspiration

This project is inspired by [Tearable Cloth](https://codepen.io/dissimulate/pen/eZxEBO) by [Dissimulate](https://codepen.io/dissimulate).

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details.
