import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

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
                      ),
                    )
                  ],
                ),
              ).animate().scaleX(
                    duration: 500.milliseconds,
                    curve: Curves.easeInOut,
                    begin: 0,
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

  static Widget loading({required String loading}) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.black500,
              strokeWidth: 1.8,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              loading,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.whitish100,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
