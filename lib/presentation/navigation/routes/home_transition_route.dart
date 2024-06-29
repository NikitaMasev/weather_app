import 'package:flutter/material.dart';

class HomeTransitionRoute<T> extends PageRouteBuilder<T> {
  HomeTransitionRoute({required this.child})
      : super(
          pageBuilder: (
            final context,
            final animation,
            final secondaryAnimation,
          ) =>
              child,
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder:
              (final ctx, final anim, final secAnim, final child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: anim,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );

  final Widget child;
}
