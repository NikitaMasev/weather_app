import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/pages/start_flow/splash_page.dart';
import 'package:weather_app/presentation/theming/models/theme_builder.dart';

class App extends StatelessWidget {
  const App(this.initialPlatformDependencies);

  final InitialPlatformDependencies initialPlatformDependencies;

  @override
  Widget build(final BuildContext context) {
    print('BUILD App');
    return ListenableBuilder(
        listenable: ThemeModeProvider.of(context),
        builder: (final ctx, final _) {
          print('BUILD ListenableBuilder');
          return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeBuilder.getLightTheme(),
          darkTheme: ThemeBuilder.getDarkTheme(),
          themeMode: ThemeModeProvider.of(ctx).themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (final ctxHome) {
              print('BUILD internal Builder');
              return SplashPage(
              appDependenciesConfigurator: AppDependenciesConfigurator(
                env: initialPlatformDependencies.env,
                sharedPlatformPersistentImpl:
                    initialPlatformDependencies.sharedPlatformPersistent,
                appLocalizations: AppLocalizations.of(ctxHome)!,
              ),
            );
            },
          ),
        );
        },
      );
  }
}
