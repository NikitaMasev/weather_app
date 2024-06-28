import 'package:flutter/material.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/di/providers/app_dependencies_provider.dart';
import 'package:weather_app/presentation/navigation/routes/home_route.dart';
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
      AppDependenciesProvider.setUp(context, appDependencies);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          HomeRoute.create(),
        );
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
