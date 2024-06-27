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

  static ThemeModeProvider provider(
    final BuildContext context, {
    final bool listen = true,
  }) {
    if (listen) {
      final provider =
          context.dependOnInheritedWidgetOfExactType<ThemeModeProvider>();
      if (provider == null) {
        throw Exception('ThemeModeManager not founded!');
      }
      return provider;
    } else {
      final element =
          context.getElementForInheritedWidgetOfExactType<ThemeModeProvider>();
      if (element == null) {
        throw Exception('ThemeModeProvider as inherited'
            ' element not founded!');
      }
      return element.widget as ThemeModeProvider;
    }
  }

  static ThemeModeManager of(
    final BuildContext context, {
    final bool listen = true,
  }) {
    final scope = provider(context, listen: listen);

    return scope.themeModeManager;
  }
}
