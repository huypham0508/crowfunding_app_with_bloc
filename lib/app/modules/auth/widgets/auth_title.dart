part of '../index.dart';

class AuthTitle extends StatelessWidget {
  final String titleString;
  const AuthTitle({super.key, required this.titleString});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        titleString,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.black100,
        ),
      ),
    );
  }
}
