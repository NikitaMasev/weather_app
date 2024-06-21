import 'package:flutter/material.dart';

class ProgressDescriptionAnimation extends StatelessWidget {
  const ProgressDescriptionAnimation({
    required this.text,
    required this.animationProgressIndicator,
    super.key,
  });

  final String text;
  final Tween<double> animationProgressIndicator;

  @override
  Widget build(final BuildContext context) => Column(
      children: [
        TweenAnimationBuilder(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 1),
          tween: animationProgressIndicator,
          builder: (
            final ctx,
            final val,
            final _,
          ) =>
              LinearProgressIndicator(///TODO make rounded edge
            value: val,
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        Text(text),
      ],
    );
}
