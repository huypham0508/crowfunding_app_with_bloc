import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CheckCustom extends StatelessWidget {
  const CheckCustom(
      {super.key,
      this.background = AppColors.primary600,
      this.icon = Icons.check});

  final Color? background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        icon,
        color: AppColors.whitish100,
        size: 50,
      )
          .animate()
          .fade(
            delay: 850.ms,
            duration: 1000.ms,
            curve: Curves.linearToEaseOut,
          )
          .moveX(delay: 850.ms),
    )
        .animate()
        .fade(
          delay: 400.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .scale(
          delay: 400.ms,
        );
  }
}
