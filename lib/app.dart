import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/di/configurators/initial_platform_dependencies.dart';
import 'package:weather_app/presentation/theming/theme_builder.dart';
import 'package:weather_app/presentation/theming/theme_mode_extension.dart';
import 'package:weather_app/presentation/theming/theme_mode_manager.dart';

class ThemeModeScope extends InheritedWidget {
  const ThemeModeScope({
    required this.themeModeManager,
    required super.child,
  });

  final ThemeModeManager themeModeManager;

  @override
  bool updateShouldNotify(covariant final InheritedWidget oldWidget) =>
      oldWidget != this;

  static ThemeModeManager of(final BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();

    if (scope == null) {
      throw Exception('ThemeModeScope not founded');
    }
    return scope.themeModeManager;
  }
}

class App extends StatelessWidget {
  App({
    required this.removeNativeSplash,
    required this.initialPlatformDependencies,
  }) {
    removeNativeSplash.call();
    initialPlatformDependencies.platformBarController.setUpBarNormalStyle();
  }

  final VoidCallback removeNativeSplash;
  final InitialPlatformDependencies initialPlatformDependencies;

/*  @override
  Widget build(final BuildContext context) => ThemeModeScope(
    themeModeManager:  ThemeModeManager(
      themePersistent: initialPlatformDependencies.sharedPlatformPersistent,
      savedThemeMode: initialPlatformDependencies.savedThemeModeStr,
      platformBarController:
      initialPlatformDependencies.platformBarController,
    ),
    child: ListenableBuilder(
      listenable: ThemeModeScope.of(context),
      builder: (final ctx, final child)=>MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeBuilder.getLightTheme(),
        darkTheme: ThemeBuilder.getDarkTheme(),
        themeMode: ThemeModeScope.of(context).themeMode,
        home: const MyHomePage(title: 'Weather Demo App'),
      ),
    ),
  );*/

  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
        create: (final ctx) => ThemeModeManager(
          themePersistent: initialPlatformDependencies.sharedPlatformPersistent,
          savedThemeMode: initialPlatformDependencies.savedThemeModeStr,
          platformBarController:
              initialPlatformDependencies.platformBarController,
        ),
        child: Consumer<ThemeModeManager>(
          builder: (
            final ctx,
            final themeModeManager,
            final child,
          ) =>
              MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeBuilder.getLightTheme(),
            darkTheme: ThemeBuilder.getDarkTheme(),
            themeMode: themeModeManager.themeMode,
            home: const MyHomePage(title: 'Weather Demo App'),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    final themeModeManager =
        Provider.of<ThemeModeManager>(context, listen: false);
    switch (themeModeManager.themeMode) {
      case ThemeMode.system:
        themeModeManager.switchToDark();
        break;
      case ThemeMode.light:
        themeModeManager.switchToLight();
        break;
      case ThemeMode.dark:
        themeModeManager.switchToSystem();
        break;
    }
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
        title: Text(widget.title),
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
