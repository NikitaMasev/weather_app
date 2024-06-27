import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/sources/shared/shared_platform_persistent_impl.dart';
import 'package:weather_app/di/models/environments.dart';
import 'package:weather_app/presentation/theming/platform_bar_controller.dart';
import 'package:weather_app/presentation/theming/theme_builder.dart';

class InitialPlatformDependencies {
  InitialPlatformDependencies._({
    required this.sharedPlatformPersistent,
    required this.env,
    required this.savedThemeModeStr,
    required this.platformBarController,
    required this.lightTheme,
    required this.darkTheme,
  });

  final SharedPlatformPersistentImpl sharedPlatformPersistent;
  final Env env;
  final String? savedThemeModeStr;
  final PlatformBarController platformBarController;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  static Future<InitialPlatformDependencies> create() async {
    final shared = await SharedPreferences.getInstance();
    final sharedPlatform = SharedPlatformPersistentImpl(shared: shared);

    final themeModeStr = await sharedPlatform.getThemeMode();
    final darkTheme = ThemeBuilder.getDarkTheme();
    final lightTheme = ThemeBuilder.getLightTheme();

    final platformBarController = PlatformBarController(
      colorBarLightTheme: lightTheme.colorScheme.surface,
      colorBarDarkTheme: darkTheme.colorScheme.surface,
      colorHomeBarLightTheme: lightTheme.colorScheme.surfaceContainer,
      colorHomeBarDarkTheme: darkTheme.colorScheme.surfaceContainer,
    );

    final env = Env.parse(
      const String.fromEnvironment('ENV', defaultValue: 'test'),
    );

    return InitialPlatformDependencies._(
      sharedPlatformPersistent: sharedPlatform,
      env: env,
      savedThemeModeStr: themeModeStr,
      platformBarController: platformBarController,
      lightTheme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
