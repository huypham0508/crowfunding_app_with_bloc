import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double widthAvatarBox = 80;
    return FadeScale(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 200.0,
            maxHeight: height * 0.7,
          ),
          child: BoxShadowCustom(
            child: Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                color: AppColors.whitish100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                          width: 100,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
