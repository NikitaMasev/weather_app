import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/main_flow/detail_page.dart';
import 'package:weather_app/presentation/pages/main_flow/settings_page.dart';

class SettingsFlow extends StatelessWidget {
  const SettingsFlow({
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
                return const SettingsPage();
              case '/detail':
                return const DetailPage(fromPage: 'SettingsFlow');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
}
