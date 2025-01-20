import 'package:flutter/material.dart';

class AnimationRoute extends PageRouteBuilder {
  final dynamic page;
  AnimationRoute({this.page})
      : super(
            pageBuilder: (context, animation, animation2) => page,
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, animation2, child) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
