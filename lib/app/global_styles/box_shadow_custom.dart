import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';

class BoxShadowCustom extends StatelessWidget {
  const BoxShadowCustom({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: AppColors.shadowPrimary),
      child: child,
    );
  }
}
