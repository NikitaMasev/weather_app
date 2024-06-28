import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/main_flow/home_page.dart';

sealed class HomeRoute {
  static Route<T> create<T>() => PageRouteBuilder<T>(
        pageBuilder: (
          final ctx,
          final anim,
          final secAnim,
        ) =>
            const HomePage(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (
          final ctx,
          final anim,
          final secAnim,
          final child,
        ) {
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
}
