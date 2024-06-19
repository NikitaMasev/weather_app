import 'package:flutter/material.dart';
import 'package:weather_app/di/providers/theme_mode_provider.dart';
import 'package:weather_app/presentation/theming/theme_builder.dart';
import 'package:weather_app/presentation/theming/theme_mode_extension.dart';
import 'package:weather_app/presentation/theming/theme_mode_manager.dart';

class App extends StatelessWidget {
  const App();

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: ThemeModeProvider.of(context),
        builder: (final ctx, final _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeBuilder.getLightTheme(),
          darkTheme: ThemeBuilder.getDarkTheme(),
          themeMode: ThemeModeProvider.of(ctx).themeMode,
          home: const MyHomePage(title: 'Weather Demo App'),
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
