import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';

class BoxShadowCustom extends StatelessWidget {
  const BoxShadowCustom({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.black500.withOpacity(0.07),
          spreadRadius: 3,
          blurRadius: 10,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ]),
      child: child,
    );
  }
}
