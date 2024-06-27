import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/main_flow/current_weather_page.dart';
import 'package:weather_app/presentation/pages/main_flow/detail_page.dart';

class CurrentWeatherFlow extends StatelessWidget {
  const CurrentWeatherFlow({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(final BuildContext context) => Navigator(
        key: navigatorKey,
        onGenerateRoute: (final routeSettings) => MaterialPageRoute(
          settings: routeSettings,
          builder: (final ctx) {
            switch (routeSettings.name) {
              case '/':
                return const CurrentWeatherPage();
              case '/detail':
                return const DetailPage(fromPage: 'CurrentWeatherFlow');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
}
