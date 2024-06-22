import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/di/providers/app_dependencies_provider.dart';
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
      ///TODO Navigate to next screen
      AppDependenciesProvider.setUp(context, appDependencies);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (final ctx) => const MyHomePage(),
        ),
      );
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
    return Scaffold(
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
