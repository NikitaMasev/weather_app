import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/di/configurators/app_dependencies_configurator.dart';
import 'package:weather_app/presentation/widgets/anim/progress_description_animation.dart';

class ProgressLoaderDependencies extends StatefulWidget {
  const ProgressLoaderDependencies({
    required this.streamDependencies,
    super.key,
  });

  final Stream<AppDependenciesState> streamDependencies;

  @override
  State<ProgressLoaderDependencies> createState() =>
      _ProgressLoaderDependenciesState();
}

class _ProgressLoaderDependenciesState
    extends State<ProgressLoaderDependencies> {
  var _animationProgressIndicator = Tween<double>(
    begin: 0,
    end: 0,
  );

  @override
  Widget build(final BuildContext context) => StreamBuilder<AppDependenciesState>(
      stream: widget.streamDependencies,
      initialData: AppDependenciesState.initial(),
      builder: (final ctx, final snap) => switch (snap.data!) {
        AppDependenciesInitial() => ProgressDescriptionAnimation(
            text: '',
            animationProgressIndicator: _animationProgressIndicator,
          ),
        AppDependenciesLoading(
          progressPercent: final progress,
          description: final msg,
        ) =>
          ProgressDescriptionAnimation(
            text: msg,
            animationProgressIndicator: _animationProgressIndicator = Tween(
              begin: _animationProgressIndicator.end,
              end: progress,
            ),
          ),
        AppDependenciesSuccess() => ProgressDescriptionAnimation(
            text: AppLocalizations.of(context)!.dependReady,
            animationProgressIndicator: _animationProgressIndicator = Tween(
              begin: _animationProgressIndicator.end,
              end: 1,
            ),
          ),
      },
    );
}
