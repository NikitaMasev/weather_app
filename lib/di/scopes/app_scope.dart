import 'package:flutter/material.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/theming/theme_mode_manager.dart';

class AppScope extends StatelessWidget {
  const AppScope({
    required this.initialPlatformDependencies,
    required this.child,
  });

  final InitialPlatformDependencies initialPlatformDependencies;
  final Widget child;

  @override
  Widget build(final BuildContext context) => ThemeModeProvider(
        themeModeManager: ThemeModeManager(
          themePersistent: initialPlatformDependencies.sharedPlatformPersistent,
          savedThemeMode: initialPlatformDependencies.savedThemeModeStr,
          platformBarController:
              initialPlatformDependencies.platformBarController,
        ),
        child: child,
      );
}
