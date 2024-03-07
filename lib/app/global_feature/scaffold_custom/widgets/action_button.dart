import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
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
                child: Container(
                  margin: GlobalStyles.paddingPageLeftRight_24,
                  child: const Icon(
                    Icons.menu,
                    color: AppColors.black500,
                    size: 28,
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
