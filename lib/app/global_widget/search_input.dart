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
    this.focusNode,
    this.loading = false,
  });

  final TextEditingController? controller;
  final Function()? onSearch;
  final Function(bool)? onFocusChange;
  final FocusNode? focusNode;
  final bool loading;

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
                    focusNode: focusNode,
                    controller: controller,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    cursorColor: AppColors.black500,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.black500,
                    ),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral400,
                      ),
                      // labelText: "Do fundrise now",
                      hintText: "Do fundrise now",
                      labelStyle: TextStyle(
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
                  child: loading
                      ? _loadingButton()
                      : Image.asset(AppImages.icSearch),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _loadingButton() {
    return const SizedBox(
      height: 14.33,
      width: 14.33,
      child: CircularProgressIndicator(
        color: AppColors.whitish100,
        strokeWidth: 0.5,
      ),
    );
  }
}
