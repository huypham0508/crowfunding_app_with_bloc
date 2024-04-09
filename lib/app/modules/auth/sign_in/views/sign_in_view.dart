import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/container_input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignInView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.whitish100,
      child: SafeArea(
        child: BlocProvider(
          create: (context) {
            return SignInBloc(
              authRepository: AuthRepository(
                graphQLClient: context.read<GraphQLService>(),
                localDataSource: context.read<LocalDataSource>(),
              ),
            );
          },
          child: BlocConsumer<SignInBloc, SignInState>(
            listener: ((
              context,
              state,
            ) {
              switch (state.status) {
                case SignInStatus.loading:
                  showDialog(
                    context: context,
                    barrierColor: AppColors.black300.withOpacity(0.2),
                    builder: (context) => Utils.loading(loading: 'Loading...'),
                  );
                  break;
                case SignInStatus.loginSuccess:
                  authBloc.add(CheckAuthEvent());
                  break;
                case SignInStatus.backDialog:
                  context.pop();
                  break;
                default:
              }
            }),
            builder: (context, state) {
              return Center(
                child: FadeMoveLeftToRight(
                  child: Container(
                    margin: EdgeInsets.only(top: 14),
                    width: size.width - 48,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.whitish100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _logoApp(),
                          _formLogin(signInState: state, context: context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _formLogin({
    required BuildContext context,
    required SignInState signInState,
  }) {
    return BoxShadowCustom(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.whitish100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              FlutterI18n.translate(
                context,
                "auth.sign_in.title",
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.black100,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  FlutterI18n.translate(
                    context,
                    "auth.sign_in.do_not_have_account",
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral300,
                  ),
                ),
                _toSignUp(
                  onPressed: () {
                    authBloc.add(
                      SwitchAuthPageEvent(
                        authPage: AuthPage.signUp,
                      ),
                    );
                  },
                  text: FlutterI18n.translate(
                    context,
                    "auth.sign_in.sign_up",
                  ),
                )
              ],
            ),
            GlobalStyles.sizedBoxHeight_24,
            _loginWithGoogleButton(context),
            GlobalStyles.sizedBoxHeight_24,
            ErrorMessage(errorMessage: signInState.errorMessage),
            InputAuthCustom(
              textController: signInState.signInEmailSController,
              hinText: 'example@gmail.com',
              title: 'Email *',
              onChange: (value) {
                context.read<SignInBloc>().add(
                      StartedLoginEvent(
                        type: StartedLoginEventEnum.email,
                        context: context,
                        loginModel: LoginModel(
                          email: signInState.signInEmailSController.text,
                          password: signInState.signInPasswordController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            InputAuthCustom(
              textController: signInState.signInPasswordController,
              hinText: 'Enter password',
              title: 'Password *',
              obscureText: true,
              onChange: (value) {
                context.read<SignInBloc>().add(
                      StartedLoginEvent(
                        type: StartedLoginEventEnum.password,
                        context: context,
                        loginModel: LoginModel(
                          email: signInState.signInEmailSController.text,
                          password: signInState.signInPasswordController.text,
                        ),
                      ),
                    );
              },
            ),
            GlobalStyles.sizedBoxHeight_10,
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'Forgot password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary600,
                ),
              ),
            ),
            GlobalStyles.sizedBoxHeight_24,
            GestureDetector(
              onTap: () {
                context.read<SignInBloc>().add(
                      StartedLoginEvent(
                        context: context,
                        type: StartedLoginEventEnum.submitted,
                        loginModel: LoginModel(
                          email: signInState.signInEmailSController.text,
                          password: signInState.signInPasswordController.text,
                        ),
                      ),
                    );
              },
              child: Container(
                child: Container(
                  width: double.maxFinite,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: AppColors.primary600,
                    ),
                    color: AppColors.primary600,
                  ),
                  child: Center(
                    child: Text(
                      FlutterI18n.translate(
                        context,
                        "auth.sign_in.title",
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whitish100,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginWithGoogleButton(BuildContext context) {
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

  Widget _toSignUp({required String text, void Function()? onPressed}) {
    return Transform.translate(
      offset: Offset(-7, 1),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primary600,
          ),
        ),
      ),
    );
  }

  Widget _logoApp() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: AppColors.neutral300,
        ),
      ),
      padding: EdgeInsets.all(5),
      child: Image.asset(
        AppImages.icLogoNoBg,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
