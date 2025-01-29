part of '../index.dart';

class ToPage extends StatelessWidget {
  ToPage({super.key, this.onPressed, required this.text, this.textStyle});

  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary600,
              ),
        ),
      ),
    );
  }
}
