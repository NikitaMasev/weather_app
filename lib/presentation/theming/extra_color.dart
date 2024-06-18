import 'package:flutter/material.dart';

class ExtraColor extends ThemeExtension<ExtraColor> {
  ExtraColor({
    required this.colorDeepOrange,
    required this.blue,
  });

  final Color colorDeepOrange;
  final Color blue;

  @override
  ThemeExtension<ExtraColor> copyWith({
    final Color? colorDeepOrange,
    final Color? blue,
  }) =>
      ExtraColor(
        colorDeepOrange: colorDeepOrange ?? this.colorDeepOrange,
        blue: blue ?? this.blue,
      );

  @override
  ThemeExtension<ExtraColor> lerp(
    covariant final ThemeExtension<ExtraColor>? other,
    final double t,
  ) {
    if (other is! ExtraColor) {
      return this;
    }
    return ExtraColor(
      colorDeepOrange: Color.lerp(colorDeepOrange, other.colorDeepOrange, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
    );
  }
}
