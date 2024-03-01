import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    this.onTapMenu,
  });
  final Function()? onTapMenu;

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
              Container(
                margin: GlobalStyles.paddingPageLeftRight_24,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1707345512638-997d31a10eaa?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
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
