import 'package:flutter/material.dart';
import 'package:weather_app/presentation/navigation/routes/nested_transition_route.dart';
import 'package:weather_app/presentation/pages/settings_flow/settings_page.dart';
import 'package:weather_app/presentation/pages/shared_pages/detail_page.dart';

class SettingsFlow extends StatelessWidget {
  const SettingsFlow({
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
                return const SettingsPage();
              case DetailPage.routePath:
                return const DetailPage(fromPage: 'SettingsFlow');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
}
