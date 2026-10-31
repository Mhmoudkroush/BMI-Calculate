import 'package:flutter/widgets.dart';

extension ResponsiveContext on BuildContext {
  static const double wide = 800;
  static const double contentNarrow = 600;
  static const double contentWide = 900;

  static const double baseWidth = 400;

  bool get isWide => MediaQuery.sizeOf(this).width >= wide;

  double get maxContentWidth => isWide ? contentWide : contentNarrow;

  double r(double size) =>
      size *
      (MediaQuery.sizeOf(this).width / baseWidth).clamp(0.8, 1.2).toDouble();
}