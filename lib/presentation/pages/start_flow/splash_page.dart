import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/presentation/assets_paths/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    required this.appDependenciesConfigurator,
    super.key,
  });

  final AppDependenciesConfigurator appDependenciesConfigurator;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  var _animationProgressIndicator = Tween<double>(
    begin: 0,
    end: 0,
  );

  late final AnimationController _animationController;
  late final Animation<double> _animationCurve;
  late final Animation<double> _animationScaleLogo;

  @override
  void initState() {
    super.initState();
    widget.appDependenciesConfigurator
        .startConfiguration()
        .catchError((final err) {
      ///TODO If error initialization=>log and send to crashlytic
    }).then((final appDependencies) {
      ///TODO Navigate to next screen
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationCurve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationScaleLogo = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.7, end: 1), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.7), weight: 50),
    ]).animate(_animationCurve);

    _animationController.repeat();
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
            AnimatedBuilder(
              animation: _animationController,
              builder: (final ctx, final _) => Transform.scale(
                scale: _animationScaleLogo.value,
                child: Assets.svg.splashDark.svg(
                  width: sizeContent,
                ),
              ),
            ),
            const SizedBox(
              height: 62,
            ),
            StreamBuilder<AppDependenciesState>(
              //key: _keyProgressStream,
              stream:
                  widget.appDependenciesConfigurator.streamDependenciesState,
              initialData: AppDependenciesState.initial(),
              builder: (final ctx, final snap) => switch (snap.data!) {
                AppDependenciesInitial() => SizedBox(
                    width: sizeContent,
                    child: TweenAnimationBuilder(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 400),
                      tween: _animationProgressIndicator,
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
                        width: sizeContent,
                        child: TweenAnimationBuilder(
                          curve: Curves.easeInOut,
                          duration: const Duration(seconds: 1),
                          tween: _animationProgressIndicator = Tween(
                            begin: _animationProgressIndicator.end,
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
                        height: 22,
                      ),
                      Text(msg),
                    ],
                  ),
                AppDependenciesSuccess() => Column(
                    children: [
                      SizedBox(
                        width: sizeContent,
                        child: TweenAnimationBuilder(
                          curve: Curves.easeInOut,
                          duration: const Duration(seconds: 1),
                          tween: _animationProgressIndicator = Tween(
                            begin: _animationProgressIndicator.end,
                            end: 1,
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
                        height: 22,
                      ),
                      Text(AppLocalizations.of(context)!.dependReady),
                    ],
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
