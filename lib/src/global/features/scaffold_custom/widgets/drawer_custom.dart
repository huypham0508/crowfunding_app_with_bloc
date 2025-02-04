import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/box_shadow_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
