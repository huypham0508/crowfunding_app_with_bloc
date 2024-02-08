import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeScale extends StatelessWidget {
  final Widget child;
  const FadeScale({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    )
        .animate()
        .fade(
          delay: 300.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .scale(
          delay: 300.ms,
        );
  }
}
