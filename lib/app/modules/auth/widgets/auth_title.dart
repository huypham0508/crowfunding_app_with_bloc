import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String titleString;
  const AuthTitle({super.key, required this.titleString});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 32.0, bottom: 24),
          child: Text(
            titleString,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
