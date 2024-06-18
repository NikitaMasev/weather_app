import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theming/extra_color.dart';

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
        primary: Color(4283196971),
        surfaceTint: Color(4283196971),
        onPrimary: Color(4294967295),
        primaryContainer: Color(4291685795),
        onPrimaryContainer: Color(4279246848),
        secondary: Color(4283982409),
        onSecondary: Color(4294967295),
        secondaryContainer: Color(4292667336),
        onSecondaryContainer: Color(4279574027),
        tertiary: Color(4281886307),
        onTertiary: Color(4294967295),
        tertiaryContainer: Color(4290571495),
        onTertiaryContainer: Color(4278198302),
        error: Color(4290386458),
        onError: Color(4294967295),
        errorContainer: Color(4294957782),
        onErrorContainer: Color(4282449922),
        surface: Color(4294572783),
        onSurface: Color(4279901206),
        onSurfaceVariant: Color(4282665021),
        outline: Color(4285888876),
        outlineVariant: Color(4291152058),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4281282858),
        inversePrimary: Color(4289843594),
        primaryFixed: Color(4291685795),
        onPrimaryFixed: Color(4279246848),
        primaryFixedDim: Color(4289843594),
        onPrimaryFixedVariant: Color(4281683478),
        secondaryFixed: Color(4292667336),
        onSecondaryFixed: Color(4279574027),
        secondaryFixedDim: Color(4290759597),
        onSecondaryFixedVariant: Color(4282403379),
        tertiaryFixed: Color(4290571495),
        onTertiaryFixed: Color(4278198302),
        tertiaryFixedDim: Color(4288729291),
        onTertiaryFixedVariant: Color(4280241739),
        surfaceDim: Color(4292533200),
        surfaceBright: Color(4294572783),
        surfaceContainerLowest: Color(4294967295),
        surfaceContainerLow: Color(4294178025),
        surfaceContainer: Color(4293849059),
        surfaceContainerHigh: Color(4293454302),
        surfaceContainerHighest: Color(4293059544),
      );

  static ColorScheme _darkScheme() => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(4289843594),
        surfaceTint: Color(4289843594),
        onPrimary: Color(4280235777),
        primaryContainer: Color(4281683478),
        onPrimaryContainer: Color(4291685795),
        secondary: Color(4290759597),
        onSecondary: Color(4280955678),
        secondaryContainer: Color(4282403379),
        onSecondaryContainer: Color(4292667336),
        tertiary: Color(4288729291),
        onTertiary: Color(4278204213),
        tertiaryContainer: Color(4280241739),
        onTertiaryContainer: Color(4290571495),
        error: Color(4294948011),
        onError: Color(4285071365),
        errorContainer: Color(4287823882),
        onErrorContainer: Color(4294957782),
        surface: Color(4279374862),
        onSurface: Color(4293059544),
        onSurfaceVariant: Color(4291152058),
        outline: Color(4287599237),
        outlineVariant: Color(4282665021),
        shadow: Color(4278190080),
        scrim: Color(4278190080),
        inverseSurface: Color(4293059544),
        inversePrimary: Color(4283196971),
        primaryFixed: Color(4291685795),
        onPrimaryFixed: Color(4279246848),
        primaryFixedDim: Color(4289843594),
        onPrimaryFixedVariant: Color(4281683478),
        secondaryFixed: Color(4292667336),
        onSecondaryFixed: Color(4279574027),
        secondaryFixedDim: Color(4290759597),
        onSecondaryFixedVariant: Color(4282403379),
        tertiaryFixed: Color(4290571495),
        onTertiaryFixed: Color(4278198302),
        tertiaryFixedDim: Color(4288729291),
        onTertiaryFixedVariant: Color(4280241739),
        surfaceDim: Color(4279374862),
        surfaceBright: Color(4281874994),
        surfaceContainerLowest: Color(4278980361),
        surfaceContainerLow: Color(4279901206),
        surfaceContainer: Color(4280164378),
        surfaceContainerHigh: Color(4280822564),
        surfaceContainerHighest: Color(4281546286),
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
