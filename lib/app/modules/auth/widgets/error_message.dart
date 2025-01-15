part of '../index.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorMessage;
  const ErrorMessage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return FadeScale(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
          child: Text(
            errorMessage ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.red500,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
