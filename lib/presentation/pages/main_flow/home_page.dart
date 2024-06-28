import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/pages/recent_search_flow/recent_search_page.dart';
import 'package:weather_app/presentation/pages/settings_flow/settings_flow.dart';
import 'package:weather_app/presentation/pages/weather_flow/current_weather_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  var _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTabIndex);
    ThemeModeProvider.of(context, listen: false).setUpBarHomeStyle();
  }

  final _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
    3,
    (final _) => GlobalKey<NavigatorState>(),
  );

  void _backBtnPressed(final bool didPop) {
    if (_navigatorKeys[_selectedTabIndex].currentState!.canPop()) {
      _popCurrentTabToRoot();
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }

  void _popCurrentTabToRoot() => _navigatorKeys[_selectedTabIndex]
      .currentState
      ?.pop(_navigatorKeys[_selectedTabIndex].currentContext);

  void _onPageViewSwiped(final int index) => setState(
        () => _selectedTabIndex = index,
      );

  void _onBottomNavBarSelected(final int index) {
    if (index == _selectedTabIndex &&
        _navigatorKeys[_selectedTabIndex].currentState!.canPop()) {
      _popCurrentTabToRoot();
    } else {
      _selectedTabIndex = index;
      _pageController.animateToPage(
        _selectedTabIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {});
    }
  }

  @override
  Widget build(final BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: _backBtnPressed,
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageViewSwiped,
            children: [
              CurrentWeatherFlow(navigatorKey: _navigatorKeys[0]),
              RecentSearchPage(),
              SettingsFlow(navigatorKey: _navigatorKeys[2]),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedTabIndex,
            onDestinationSelected: _onBottomNavBarSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.person),
                label: '1 tab',
              ),
              NavigationDestination(
                icon: Icon(Icons.ac_unit),
                label: '2 tab',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: '3 tab',
              ),
            ],
          ),
        ),
      );
}
