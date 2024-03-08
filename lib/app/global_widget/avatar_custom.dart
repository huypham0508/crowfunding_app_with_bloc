import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AvatarCustom extends StatelessWidget {
  const AvatarCustom({
    super.key,
    required this.widthAvatarBox,
  });

  final double widthAvatarBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widthAvatarBox),
      ),
      clipBehavior: Clip.hardEdge,
      width: widthAvatarBox,
      height: widthAvatarBox + 50,
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: widthAvatarBox,
          height: widthAvatarBox,
          decoration: BoxDecoration(
            color: AppColors.primary500,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widthAvatarBox),
              topRight: Radius.circular(widthAvatarBox),
            ),
          ),
          child: Image.asset(
            AppImages.imAvatar,
            width: widthAvatarBox,
          )
              .animate(
                delay: 500.ms,
              )
              .scaleXY(
                delay: 500.ms,
                curve: Curves.fastLinearToSlowEaseIn,
                begin: 1,
                end: 2,
                duration: 1000.ms,
              )
              .moveY(
                delay: 500.ms,
                begin: 10,
                end: 0,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: 500.ms,
              )
              .saturate(
                begin: 0,
                end: 1,
              ),
        ),
      ),
    );
  }
}
