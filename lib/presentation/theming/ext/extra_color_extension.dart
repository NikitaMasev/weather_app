import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theming/models/extra_color.dart';

extension ExtraColorExtension on ThemeData {
  ExtraColor get extraColors =>
      extension<ExtraColor>() ??
      ExtraColor(
        colorDeepOrange: Colors.white,
        blue: Colors.white,
      );
}
