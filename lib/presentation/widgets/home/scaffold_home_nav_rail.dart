import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/presentation/assets_paths/assets.gen.dart';

class ScaffoldHomeNavRail extends StatelessWidget {
  const ScaffoldHomeNavRail({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.iconSize,
    super.key,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final double iconSize;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              //labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Assets.svg.weather.svg(width: iconSize),
                  selectedIcon: Assets.svg.weatherActive.svg(
                    width: iconSize,
                  ),
                  label: Text(AppLocalizations.of(context)!.navTabWeatherText),
                ),
                NavigationRailDestination(
                  icon: Assets.svg.history.svg(width: iconSize),
                  selectedIcon: Assets.svg.historyActive.svg(
                    width: iconSize,
                  ),
                  label: Text(AppLocalizations.of(context)!.navTabHistoryText),
                ),
                NavigationRailDestination(
                  icon: Assets.svg.settings.svg(width: iconSize),
                  selectedIcon: Assets.svg.settingsActive.svg(
                    width: iconSize,
                  ),
                  label: Text(AppLocalizations.of(context)!.navTabSettingsText),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: body,
            ),
          ],
        ),
      );
}
