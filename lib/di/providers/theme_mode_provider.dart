import 'package:flutter/material.dart';
import 'package:weather_app/di/notifiers/theme_mode_manager.dart';

class ThemeModeProvider extends InheritedWidget {
  const ThemeModeProvider({
    required this.themeModeManager,
    required super.child,
  });

  final ThemeModeManager themeModeManager;

  @override
  bool updateShouldNotify(covariant final ThemeModeProvider oldWidget) =>
      themeModeManager.themeMode != oldWidget.themeModeManager.themeMode;

  static ThemeModeManager of(final BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ThemeModeProvider>();

    if (scope == null) {
      throw Exception('ThemeModeProvider not founded');
    }
    return scope.themeModeManager;
  }
}
