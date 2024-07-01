import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theming/models/extra_color.dart';

///TODO TextTheme
sealed class ThemeBuilder {
  static ThemeData getLightTheme() => _theme(
        colorScheme: _lightScheme(),
        textTheme: TextTheme(),
        themeExtensions: _getLightExtensions(),
      );

  static ThemeData getDarkTheme() => _theme(
        colorScheme: _darkScheme(),
        textTheme: TextTheme(),
        themeExtensions: _getDarkExtensions(),
      );

  static ThemeData _theme({
    required final ColorScheme colorScheme,
    required final TextTheme textTheme,
    required final List<ThemeExtension> themeExtensions,
  }) =>
      ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        extensions: themeExtensions,
      );

  static ColorScheme _lightScheme() => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(4278217316),
        surfaceTint: Color(4278217316),
        onPrimary: Color(4294967295),
        primaryContainer: Color(4288541417),
        onPrimaryContainer: Color(4278198302),
        secondary: Color(4283065184),
        onSecondary: Color(4294967295),
        secondaryContainer: Color(4291619044),
        onSecondaryContainer: Color(4278525725),
        tertiary: Color(4282933626),
        onTertiary: Color(4294967295),
        tertiaryContainer: Color(4291814911),
        onTertiaryContainer: Color(4278197556),
        error: Color(4290386458),
        onError: Color(4294967295),
        errorContainer: Color(4294957782),
        onErrorContainer: Color(4282449922),
        surface: Color(4294245369),
        onSurface: Color(4279639324),
        onSurfaceVariant: Color(4282337607),
        outline: Color(4285495671),
        outlineVariant: Color(4290693574),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4281020977),
        inversePrimary: Color(4286698957),
        primaryFixed: Color(4288541417),
        onPrimaryFixed: Color(4278198302),
        primaryFixedDim: Color(4286698957),
        onPrimaryFixedVariant: Color(4278210635),
        secondaryFixed: Color(4291619044),
        onSecondaryFixed: Color(4278525725),
        secondaryFixedDim: Color(4289776840),
        onSecondaryFixedVariant: Color(4281486153),
        tertiaryFixed: Color(4291814911),
        onTertiaryFixed: Color(4278197556),
        tertiaryFixedDim: Color(4289710567),
        onTertiaryFixedVariant: Color(4281354594),
        surfaceDim: Color(4292205530),
        surfaceBright: Color(4294245369),
        surfaceContainerLowest: Color(4294967295),
        surfaceContainerLow: Color(4293916147),
        surfaceContainer: Color(4293521389),
        surfaceContainerHigh: Color(4293126632),
        surfaceContainerHighest: Color(4292732130),
      );

  static ColorScheme _darkScheme() => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(4286698957),
        surfaceTint: Color(4286698957),
        onPrimary: Color(4278204212),
        primaryContainer: Color(4278210635),
        onPrimaryContainer: Color(4288541417),
        secondary: Color(4289776840),
        onSecondary: Color(4280038706),
        secondaryContainer: Color(4281486153),
        onSecondaryContainer: Color(4291619044),
        tertiary: Color(4289710567),
        onTertiary: Color(4279775818),
        tertiaryContainer: Color(4281354594),
        onTertiaryContainer: Color(4291814911),
        error: Color(4294948011),
        onError: Color(4285071365),
        errorContainer: Color(4287823882),
        onErrorContainer: Color(4294957782),
        surface: Color(4279112980),
        onSurface: Color(4292732130),
        onSurfaceVariant: Color(4290693574),
        outline: Color(4287206289),
        outlineVariant: Color(4282337607),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4292732130),
        inversePrimary: Color(4278217316),
        primaryFixed: Color(4288541417),
        onPrimaryFixed: Color(4278198302),
        primaryFixedDim: Color(4286698957),
        onPrimaryFixedVariant: Color(4278210635),
        secondaryFixed: Color(4291619044),
        onSecondaryFixed: Color(4278525725),
        secondaryFixedDim: Color(4289776840),
        onSecondaryFixedVariant: Color(4281486153),
        tertiaryFixed: Color(4291814911),
        onTertiaryFixed: Color(4278197556),
        tertiaryFixedDim: Color(4289710567),
        onTertiaryFixedVariant: Color(4281354594),
        surfaceDim: Color(4279112980),
        surfaceBright: Color(4281612857),
        surfaceContainerLowest: Color(4278783759),
        surfaceContainerLow: Color(4279639324),
        surfaceContainer: Color(4279902496),
        surfaceContainerHigh: Color(4280625962),
        surfaceContainerHighest: Color(4281284149),
      );

  static List<ThemeExtension> _getLightExtensions() => [
        ExtraColor(
          colorDeepOrange: Colors.deepOrange,
          blue: Colors.blueAccent,
        ),
      ];

  static List<ThemeExtension> _getDarkExtensions() => [
        ExtraColor(
          colorDeepOrange: Colors.deepOrange.shade900,
          blue: Colors.blueAccent.shade700,
        ),
      ];
}
