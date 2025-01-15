part of '../index.dart';

class ButtonAuthCustom extends StatelessWidget {
  const ButtonAuthCustom({
    super.key,
    required this.text,
    required this.onTap,
    required this.context,
    this.backgroundColor,
  });

  final String text;
  final void Function()? onTap;
  final BuildContext context;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Container(
          width: double.maxFinite,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: backgroundColor ?? AppColors.primary600,
            ),
            color: AppColors.primary600,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.whitish100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
