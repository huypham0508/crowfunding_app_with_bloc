import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Utils {
  static Timer setTimeout(callback, time) {
    Duration timeDelay = Duration(milliseconds: time);
    return Timer(timeDelay, callback);
  }

  static dialogNotification(BuildContext context, content, Widget logo) {
    showDialog(
      context: context,
      barrierColor: AppColors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.neutral400,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black500.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: logo,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        content,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 14,
                        minFontSize: 10,
                        style: TextStyle(color: AppColors.whitish100),
                      ).animate().fade(delay: 400.milliseconds),
                    )
                  ],
                ),
              )
                  .animate()
                  .scaleX(
                    delay: 200.milliseconds,
                    duration: 500.milliseconds,
                    curve: Curves.easeInOut,
                    begin: 0.3,
                    end: 1,
                  )
                  .scaleY(
                    duration: 200.milliseconds,
                    curve: Curves.easeInOut,
                    begin: -1,
                    end: 1,
                  ),
            ],
          ),
        );
      },
    );
    setTimeout(() {
      context.pop();
    }, 2000);
  }

  static showLoading(BuildContext context) {
    final dialog = showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.black300.withOpacity(0.2),
      builder: (context) => loading(loading: 'Loading...'),
    );
    return dialog;
  }

  static Widget loading({required String loading}) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: AppColors.secondary500,
                rightDotColor: AppColors.primary600,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void closeLoading(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
