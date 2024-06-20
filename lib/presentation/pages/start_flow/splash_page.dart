import 'package:flutter/material.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';

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
  var _tweenProgress = Tween(begin: 0.0, end: 0.0);

  @override
  void initState() {
    super.initState();
    widget.appDependenciesConfigurator
        .startConfiguration()
        .catchError((final err) {
          ///TODO If error initialization=>log and send to crashlytic
    })
        .then((final appDependencies) {
      ///TODO Navigate to next screen
    });
  }

  @override
  void dispose() {
    widget.appDependenciesConfigurator.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/png/splash_dark.png'),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<AppDependenciesState>(
                stream:
                    widget.appDependenciesConfigurator.streamDependenciesState,
                initialData: AppDependenciesState.initial(),
                builder: (final ctx, final snap) => switch (snap.data!) {
                  AppDependenciesInitial() => SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: TweenAnimationBuilder(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 400),
                        tween: _tweenProgress,
                        builder: (
                          final ctx,
                          final val,
                          final _,
                        ) =>
                            LinearProgressIndicator(
                          value: val,
                        ),
                      ),
                    ),
                  AppDependenciesLoading(
                    progressPercent: final progress,
                    description: final msg,
                  ) =>
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: TweenAnimationBuilder(
                            curve: Curves.easeInOut,
                            duration: const Duration(seconds: 1),
                            tween: _tweenProgress = Tween(
                              begin: _tweenProgress.end,
                              end: progress,
                            ),
                            builder: (
                              final ctx,
                              final val,
                              final _,
                            ) =>
                                LinearProgressIndicator(
                              value: val,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(msg),
                      ],
                    ),
                  AppDependenciesSuccess() => const SizedBox.shrink(),
                },
              ),
            ],
          ),
        ),
      );
}
