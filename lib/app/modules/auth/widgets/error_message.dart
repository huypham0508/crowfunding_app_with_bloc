import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorMessage;
  const ErrorMessage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return FadeScale(
      child: Container(
        margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
        child: Text(
          errorMessage ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.red500,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
