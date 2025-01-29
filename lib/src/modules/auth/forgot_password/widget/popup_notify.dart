part of '../../index.dart';

enum popUpType {
  SUCCESS,
  FAILED,
}

class PopupNotify extends StatelessWidget {
  const PopupNotify({
    super.key,
    required this.type,
    required this.textPrimary,
    this.textSecondary,
    this.textSecondaryHighlight,
  });
  final popUpType type;
  final String? textSecondary;
  final String? textSecondaryHighlight;
  final String textPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 320,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == popUpType.SUCCESS) CheckCustom(),
          if (type == popUpType.FAILED)
            CheckCustom(
              background: AppColors.red500,
              icon: Icons.close_outlined,
            ),
          GlobalStyles.sizedBoxHeight_24,
          RichText(
            text: TextSpan(
              text: textSecondary,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.neutral300,
              ),
              children: textSecondaryHighlight != null
                  ? <TextSpan>[
                      TextSpan(text: " "),
                      TextSpan(
                        text: textSecondaryHighlight,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primary600,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            textPrimary,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Spacer(),
          ButtonAuthCustom(
            context: context,
            text: 'OK',
            onTap: () => context.read<ForgotPwBloc>().add(
                  ClosePopupForgotPwEvent(),
                ),
          ),
        ],
      ),
    );
  }
}
