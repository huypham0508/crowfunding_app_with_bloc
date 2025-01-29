part of '../index.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ContainerInputCustom(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.icGoogle, width: 24),
            GlobalStyles.sizedBoxWidth,
            Text(
              FlutterI18n.translate(
                context,
                'auth.sign_in.login_google',
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
