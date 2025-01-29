import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:flutter/material.dart';

class ContainerInputCustom extends StatelessWidget {
  const ContainerInputCustom({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: AppColors.whitish500,
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
