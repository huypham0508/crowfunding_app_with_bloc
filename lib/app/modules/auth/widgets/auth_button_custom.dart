import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ButtonAuthCustom extends StatelessWidget {
  final Color? textColor;
  final Color? backgroundColor;
  final Function()? onTap;
  const ButtonAuthCustom({
    super.key,
    this.textColor,
    this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 24.0),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            shape: BoxShape.circle,
            color: backgroundColor ?? AppColors.black,
          ),
          child: Icon(
            Icons.arrow_forward_outlined,
            color: textColor ?? AppColors.lightWhite,
            size: 32,
          ),
        ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
      ),
    );
  }
}
