import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.controller,
    this.onSearch,
    this.onFocusChange,
  });

  final TextEditingController? controller;
  final Function()? onSearch;
  final Function(bool)? onFocusChange;
  @override
  Widget build(BuildContext context) {
    return FadeScale(
      child: BoxShadowCustom(
        child: Container(
          padding: const EdgeInsets.only(
            right: 7,
            bottom: 7,
            top: 7,
            left: 10,
          ),
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: AppColors.whitish100,
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: onFocusChange,
                  child: TextField(
                    controller: controller,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    cursorColor: AppColors.black500,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.black500,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      hintStyle: TextStyle(
                        color: AppColors.black400.withOpacity(0.5),
                      ),
                      labelText: "Do fundrise now",
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral400,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary600,
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  child: Image.asset(AppImages.icSearch),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
