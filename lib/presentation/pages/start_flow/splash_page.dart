import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/navigation/routes/home_transition_route.dart';
import 'package:weather_app/presentation/pages/main_flow/home_page.dart';
import 'package:weather_app/presentation/theming/ext/theme_mode_extension.dart';
import 'package:weather_app/presentation/widgets/anim/animated_logo.dart';
import 'package:weather_app/presentation/widgets/anim/progress_loader_dependencies.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    required this.appDependenciesConfigurator,
    super.key,
  });

  final AppDependenciesConfigurator appDependenciesConfigurator;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    widget.appDependenciesConfigurator
        .startConfiguration()
        .catchError((final err) {
      ///TODO If error initialization=>log and send to crashlytic
    }).then((final appDependencies) {
      //AppDependenciesProvider.setUp(context, appDependencies);

      Future.delayed(const Duration(seconds: 5), () {
        final themeManager = ThemeModeProvider.of(context);
        print(themeManager.themeMode);
        switch(themeManager.themeMode) {
          case ThemeMode.system:
            themeManager.switchToDark();
            break;
          case ThemeMode.light:
            themeManager.switchToDark();
            break;
          case ThemeMode.dark:
            themeManager.switchToLight();
            break;
        }
/*        Navigator.of(context).pushReplacement(
          HomeTransitionRoute(child: const HomePage()),
        );*/
      });
    });
  }

  @override
  void dispose() {
    widget.appDependenciesConfigurator.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final sizeContent = MediaQuery.sizeOf(context).width * 0.6;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: theme.colorScheme.surface,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          systemNavigationBarIconBrightness:
              theme.brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedLogo(
              sizeLogo: sizeContent,
            ),
            const SizedBox(
              height: 62,
            ),
            SizedBox(
              width: sizeContent,
              child: ProgressLoaderDependencies(
                streamDependencies:
                    widget.appDependenciesConfigurator.streamDependenciesState,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

