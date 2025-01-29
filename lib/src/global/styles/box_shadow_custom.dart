import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:flutter/material.dart';

class BoxShadowCustom extends StatelessWidget {
  const BoxShadowCustom({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.black500.withValues(alpha: 0.07),
          spreadRadius: 7,
          blurRadius: 20,
          blurStyle: BlurStyle.normal,
          offset: const Offset(0, 0),
        ),
      ]),
      child: child,
    );
  }
}
