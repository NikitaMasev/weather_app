import 'package:flutter/material.dart';

extension ThemeModeExtension on BuildContext {
  bool get lightTheme => Theme.of(this).brightness == Brightness.light;

  bool get darkTheme => Theme.of(this).brightness == Brightness.dark;
}
