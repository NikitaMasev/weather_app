import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

final class PlatformBarController {
  PlatformBarController({
    required final Color colorBarLightTheme,
    required final Color colorBarDarkTheme,
  })  : _colorBarDarkTheme = colorBarDarkTheme,
        _colorBarLightTheme = colorBarLightTheme;

  final Color _colorBarLightTheme;
  final Color _colorBarDarkTheme;

  bool isLightPlatformTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light;
  }

  void forceSetUpBarDarkStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: _colorBarDarkTheme,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void forceSetUpBarLightStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: _colorBarLightTheme,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void setUpBarSplashStyle() {
    if (isLightPlatformTheme()) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  void setUpBarNormalStyle() {
    if (isLightPlatformTheme()) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: _colorBarLightTheme,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: _colorBarDarkTheme,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }
}
