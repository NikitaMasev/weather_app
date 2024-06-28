import 'package:flutter/material.dart';
import 'package:weather_app/presentation/navigation/routes/nested_transition_route.dart';
import 'package:weather_app/presentation/pages/shared_pages/detail_page.dart';
import 'package:weather_app/presentation/pages/weather_flow/current_weather_page.dart';

class CurrentWeatherFlow extends StatelessWidget {
  const CurrentWeatherFlow({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(final BuildContext context) => Navigator(
        key: navigatorKey,
        onGenerateRoute: (final routeSettings) => NestedTransitionRoute(
          settings: routeSettings,
          builder: (final ctx) {
            switch (routeSettings.name) {
              case '/':
                return const CurrentWeatherPage();
              case DetailPage.routePath:
                return const DetailPage(fromPage: 'CurrentWeatherFlow');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
}
