import 'package:flutter/material.dart';

extension ThemeModeExtensionStringer on ThemeMode {
  ThemeMode parse(final String val) => ThemeMode.values.firstWhere(
        (final env) => env.name.split('.').last == val,
        orElse: () => ThemeMode.system,
      );

  String serialize() => name.split('.').last;
}
