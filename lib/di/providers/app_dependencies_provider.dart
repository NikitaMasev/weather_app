import 'package:flutter/material.dart';
import 'package:weather_app/di/models/app_dependencies.dart';
import 'package:weather_app/di/notifiers/app_dependencies_manager.dart';

class AppDependenciesProvider extends InheritedWidget {
  const AppDependenciesProvider({
    required this.appDependenciesManager,
    required super.child,
  });

  final AppDependenciesManager appDependenciesManager;

  @override
  bool updateShouldNotify(covariant final AppDependenciesProvider oldWidget) =>
      appDependenciesManager.getAppDependencies !=
      oldWidget.appDependenciesManager.getAppDependencies;

  static AppDependenciesProvider provider(final BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppDependenciesProvider>();

    if (scope == null) {
      throw Exception('AppDependenciesProvider not founded!');
    }
    return scope;
  }

  ///Must call after initialization [appDependencies] in splash page
  static void setUp(
    final BuildContext context,
    final AppDependencies appDependencies,
  ) {
    final scope = provider(context);
    scope.appDependenciesManager.setUp(appDependencies);
  }

  static AppDependencies of(final BuildContext context) {
    final scope = provider(context);

    return scope.appDependenciesManager.getAppDependencies;
  }
}
