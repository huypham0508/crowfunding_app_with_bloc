import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';

class BoxShadowCustom extends StatelessWidget {
  const BoxShadowCustom({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral200.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(10, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
