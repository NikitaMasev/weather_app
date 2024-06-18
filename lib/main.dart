import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';

void main() => _bootstrap(
      (final initialized, final platformDependencies) => App(
        removeNativeSplash: initialized,
        initialPlatformDependencies: platformDependencies,
      ),
    );

Future<void> _bootstrap(
  final Widget Function(VoidCallback, InitialPlatformDependencies) builder,
) async {
  runZonedGuarded<void>(
    () async {
      await SentryFlutter.init(
        (final options) {
          options.dsn = const String.fromEnvironment('SENTRY_KEY');
        },
      );

      final platformDependencies = await InitialPlatformDependencies.create();
      platformDependencies.platformBarController.setUpBarSplashStyle();

      //Bloc.observer = AppBlocObserver();
      runApp(builder(() {}, platformDependencies));
    },
    (final error, final stack) async {
      log(
        error.toString(),
        stackTrace: stack,
      );
      await Sentry.captureException(error, stackTrace: stack);
    },
  );

  FlutterError.onError = (final details) {
    Sentry.captureException(details, stackTrace: details.stack);
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
}
