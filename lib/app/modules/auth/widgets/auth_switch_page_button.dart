part of '../index.dart';

class SwitchPageButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const SwitchPageButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 24),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
