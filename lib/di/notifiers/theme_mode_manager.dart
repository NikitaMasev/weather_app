import 'package:flutter/material.dart';
import 'package:weather_app/data/sources/shared/theme_persistent.dart';
import 'package:weather_app/presentation/theming/platform_bar_controller.dart';
import 'package:weather_app/presentation/theming/theme_mode_extension_stringer.dart';

final class ThemeModeManager extends ChangeNotifier {
  ThemeModeManager({
    required final ThemePersistent themePersistent,
    required final PlatformBarController platformBarController,
    required final String? savedThemeMode,
  })  : _themePersistent = themePersistent,
        _platformBarController = platformBarController {
    if (savedThemeMode != null) {
      themeMode = ThemeMode.system.parse(savedThemeMode);
    } else {
      themeMode = ThemeMode.system;
    }
    _platformBarController.setUpBarNormalStyle();
  }

  final ThemePersistent _themePersistent;
  final PlatformBarController _platformBarController;
  late ThemeMode themeMode;

  void switchToLight() {
    if (themeMode != ThemeMode.light) {
      themeMode = ThemeMode.light;
      _updateThemeMode();
      _platformBarController.forceSetUpBarLightStyle();
    }
  }

  void switchToDark() {
    if (themeMode != ThemeMode.dark) {
      themeMode = ThemeMode.dark;
      _updateThemeMode();
      _platformBarController.forceSetUpBarDarkStyle();
    }
  }

  void switchToSystem() {
    if (themeMode != ThemeMode.system) {
      themeMode = ThemeMode.system;
      _updateThemeMode();
      _platformBarController.setUpBarNormalStyle();
    }
  }

  void setUpBarHomeStyle() {
    _platformBarController.setUpBarHomeStyle();
  }

  void _updateThemeMode() {
    notifyListeners();
    _themePersistent.saveThemeMode(themeMode.serialize());
  }
}
