import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/presentation/assets_paths/assets.gen.dart';

class ScaffoldHomeNavBar extends StatelessWidget {
  const ScaffoldHomeNavBar({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.iconSize,
    required this.appBar,
    super.key,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final double iconSize;
  final AppBar appBar;

  @override
  Widget build(final BuildContext context) => Scaffold(
      body: body,
      appBar: appBar,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: Assets.svg.weather.svg(width: iconSize),
            selectedIcon: Assets.svg.weatherActive.svg(
              width: iconSize,
            ),
            label: AppLocalizations.of(context)!.navTabWeatherText,
          ),
          NavigationDestination(
            icon: Assets.svg.history.svg(width: iconSize),
            selectedIcon: Assets.svg.historyActive.svg(
              width: iconSize,
            ),
            label: AppLocalizations.of(context)!.navTabHistoryText,
          ),
          NavigationDestination(
            icon: Assets.svg.settings.svg(width: iconSize),
            selectedIcon: Assets.svg.settingsActive.svg(
              width: iconSize,
            ),
            label: AppLocalizations.of(context)!.navTabSettingsText,
          ),
        ],
      ),
    );
}
