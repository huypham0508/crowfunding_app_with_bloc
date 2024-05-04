import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TabItem extends StatelessWidget {
  final bool active;
  final String tabName;
  final void Function()? onTap;

  const TabItem({
    super.key,
    this.active = false,
    required this.tabName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.whitish100 : AppColors.transparent,
              width: active ? 3 : 0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Text(
          tabName,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whitish100,
            fontWeight: active ? FontWeight.w900 : FontWeight.w500,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.2, 0.2),
                blurRadius: 0.0,
                color: AppColors.black100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
