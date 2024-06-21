import 'package:flutter/material.dart';
import 'package:weather_app/presentation/assets_paths/assets.gen.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    required this.sizeLogo,
    super.key,
  });

  final double sizeLogo;

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationCurve;
  late final Animation<double> _animationScaleLogo;

  @override
  void initState() {
    super.initState();
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        builder: (final ctx, final _) => Transform.scale(
          scale: _animationScaleLogo.value,
          child: Assets.svg.splashDark.svg(width: widget.sizeLogo),
        ),
      );
}
