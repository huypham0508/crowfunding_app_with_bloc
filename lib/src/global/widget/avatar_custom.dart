import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/animated/fade_linear_to_ease_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AvatarCustom extends StatelessWidget {
  const AvatarCustom({
    super.key,
    required this.widthAvatarBox,
    required this.image,
    this.translate = true,
  });

  final double widthAvatarBox;
  final String image;
  final bool translate;
  @override
  Widget build(BuildContext context) {
    return FadeLinearToEaseOut(
      child: Transform.translate(
        offset: !translate
            ? Offset(0, 0)
            : Offset(
                0,
                -(widthAvatarBox / 3 * 2),
              ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widthAvatarBox),
          ),
          clipBehavior: Clip.hardEdge,
          width: widthAvatarBox,
          height: widthAvatarBox + (widthAvatarBox / 3 * 2),
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
                image,
                height: widthAvatarBox,
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
        ),
      ),
    );
  }
}
