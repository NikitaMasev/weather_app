import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/pages/start_flow/splash_page.dart';
import 'package:weather_app/presentation/theming/theme_builder.dart';
import 'package:weather_app/presentation/theming/theme_mode_extension.dart';
import 'package:weather_app/presentation/theming/theme_mode_manager.dart';

class App extends StatelessWidget {
  const App(this.initialPlatformDependencies);

  final InitialPlatformDependencies initialPlatformDependencies;

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: ThemeModeProvider.of(context),
        builder: (final ctx, final _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeBuilder.getLightTheme(),
          darkTheme: ThemeBuilder.getDarkTheme(),
          themeMode: ThemeModeProvider.of(ctx).themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (final ctxHome) => SplashPage(
              appDependenciesConfigurator: AppDependenciesConfigurator(
                env: initialPlatformDependencies.env,
                sharedPlatformPersistentImpl:
                    initialPlatformDependencies.sharedPlatformPersistent,
                appLocalizations: AppLocalizations.of(ctxHome)!,
              ),
            ),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ThemeModeManager _themeModeManager;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    switch (_themeModeManager.themeMode) {
      case ThemeMode.system:
        _themeModeManager.switchToDark();
        break;
      case ThemeMode.light:
        _themeModeManager.switchToLight();
        break;
      case ThemeMode.dark:
        _themeModeManager.switchToSystem();
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeModeManager = ThemeModeProvider.of(context);
  }

  @override
  Widget build(final BuildContext context) {
    print('${context.lightTheme}');
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(AppLocalizations.of(context)!.appName),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.pressedButton(_counter),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.hello('Aboba'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.helloWorldOn(DateTime.now()),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.numberOfDataPoints(2056),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
