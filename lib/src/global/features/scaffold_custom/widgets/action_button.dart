import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/src/global/widget/search_input.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    this.onTapMenu,
    this.onTapAvatar,
  });
  final Function()? onTapMenu;
  final Function()? onTapAvatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalStyles.sizedBoxHeight_5,
        SafeArea(
          bottom: false,
          child: Row(
            children: [
              GestureDetector(
                onTap: onTapMenu,
                child: BoxShadowCustom(
                  child: Container(
                    margin: GlobalStyles.paddingPageLeftRight_24,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.whitish100,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.black500,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child: SearchInput(),
                ),
              ),
              GestureDetector(
                onTap: onTapAvatar,
                child: Container(
                  margin: GlobalStyles.paddingPageLeftRight_24,
                  child: const CircleAvatar(
                    backgroundColor: AppColors.secondary500,
                    backgroundImage: AssetImage(
                      AppImages.imAvatar,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
