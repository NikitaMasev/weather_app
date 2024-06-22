import 'package:flutter/material.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';
import 'package:weather_app/di/notifiers/app_dependencies_manager.dart';
import 'package:weather_app/di/notifiers/theme_mode_manager.dart';
import 'package:weather_app/di/providers/app_dependencies_provider.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';

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
        child: AppDependenciesProvider(
          appDependenciesManager: AppDependenciesManager(),
          child: child,
        ),
      );
}
