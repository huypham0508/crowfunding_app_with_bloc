import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeMoveLeftToRight extends StatelessWidget {
  const FadeMoveLeftToRight({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    )
        .animate()
        .fade(
          delay: 400.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .moveX(
          begin: -10,
          end: 0,
          delay: 400.ms,
        );
  }
}

class FadeMoveRightToLeft extends StatelessWidget {
  const FadeMoveRightToLeft({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    )
        .animate()
        .fade(
          delay: 400.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .moveX(
          begin: 10,
          end: 0,
          delay: 400.ms,
        );
  }
}

class FadeMoveTopToBottom extends StatelessWidget {
  const FadeMoveTopToBottom({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    )
        .animate()
        .fade(
          delay: 400.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .moveY(
          begin: -10,
          end: 0,
          delay: 400.ms,
        );
  }
}

class FadeMoveBottomToTop extends StatelessWidget {
  const FadeMoveBottomToTop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    )
        .animate()
        .fade(
          delay: 400.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .moveY(
          begin: 10,
          end: 0,
          delay: 400.ms,
        );
  }
}
