import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/container_input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignUpView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.whitish100,
      child: SafeArea(
        child: BlocProvider(
          create: (context) {
            return SignUpBloc(
              authRepository: AuthRepository(
                graphQLClient: context.read<GraphQLService>(),
                localDataSource: context.read<LocalDataSource>(),
              ),
            );
          },
          child: BlocConsumer<SignUpBloc, SignUpState>(
              listener: ((context, state) {
            switch (state.status) {
              case SignUpStatus.loading:
                showDialog(
                    context: context,
                    barrierColor: AppColors.black300.withOpacity(0.2),
                    builder: (context) => Utils.loading(loading: 'Loading...'));
                break;
              case SignUpStatus.registerSuccess:
                Utils.dialogNotification(
                  context,
                  'User registered successfully!!!',
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 20,
                      color: AppColors.whitish100,
                    ),
                  ),
                );
                Utils.setTimeout(
                  () => authBloc.add(
                    SwitchAuthPageEvent(authPage: AuthPage.signIn),
                  ),
                  2500,
                );
                break;
              case SignUpStatus.backDialog:
                context.pop();
                break;
              default:
            }
          }), builder: (context, state) {
            return Center(
              child: FadeMoveRightToLeft(
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
                        _formRegister(signUpState: state, context: context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _formRegister({
    required BuildContext context,
    required SignUpState signUpState,
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
                "auth.sign_up.title",
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
                    "auth.sign_up.have_account",
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral300,
                  ),
                ),
                _toSignIn(
                  onPressed: () {
                    authBloc.add(
                      SwitchAuthPageEvent(
                        authPage: AuthPage.signIn,
                      ),
                    );
                  },
                  text: FlutterI18n.translate(
                    context,
                    "auth.sign_up.sign_in",
                  ),
                )
              ],
            ),
            _loginWithGoogleButton(context),
            GlobalStyles.sizedBoxHeight_10,
            ErrorMessage(errorMessage: signUpState.errorMessage),
            InputAuthCustom(
              textController: signUpState.signUpUsernameController,
              hinText: 'Jhon Doe',
              title: FlutterI18n.translate(context, "auth.sign_up.full_name"),
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.username,
                        registerModel: RegisterModel(
                          username: value,
                          email: signUpState.signUpEmailSController.text,
                          password: signUpState.signUpPasswordController.text,
                          confirmPw: signUpState.signUpConfirmPwController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            InputAuthCustom(
              textController: signUpState.signUpEmailSController,
              hinText: 'example@gmail.com',
              title: FlutterI18n.translate(context, "auth.sign_up.email"),
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.email,
                        registerModel: RegisterModel(
                          username: signUpState.signUpUsernameController.text,
                          email: value,
                          password: signUpState.signUpPasswordController.text,
                          confirmPw: signUpState.signUpConfirmPwController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            InputAuthCustom(
              textController: signUpState.signUpPasswordController,
              hinText: 'Create a password',
              title: FlutterI18n.translate(context, "auth.sign_up.password"),
              obscureText: true,
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.password,
                        registerModel: RegisterModel(
                          username: signUpState.signUpUsernameController.text,
                          email: signUpState.signUpEmailSController.text,
                          password: value,
                          confirmPw: signUpState.signUpConfirmPwController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            InputAuthCustom(
              textController: signUpState.signUpConfirmPwController,
              hinText: 'Enter your password',
              title: FlutterI18n.translate(
                context,
                "auth.sign_up.confirm_password",
              ),
              obscureText: true,
              onChange: (value) {
                context.read<SignUpBloc>().add(
                      StartedSignUpEvent(
                        context: context,
                        type: StartedSignUpEventEnum.confirmPassword,
                        registerModel: RegisterModel(
                          username: signUpState.signUpUsernameController.text,
                          email: signUpState.signUpEmailSController.text,
                          password: signUpState.signUpPasswordController.text,
                          confirmPw: value,
                        ),
                      ),
                    );
              },
            ),
            GlobalStyles.sizedBoxHeight_24,
            _buttonSubmit(onTap: () {
              context.read<SignUpBloc>().add(
                    StartedSignUpEvent(
                      context: context,
                      type: StartedSignUpEventEnum.submitted,
                      registerModel: RegisterModel(
                        username: signUpState.signUpUsernameController.text,
                        email: signUpState.signUpEmailSController.text,
                        password: signUpState.signUpPasswordController.text,
                        confirmPw: signUpState.signUpConfirmPwController.text,
                      ),
                    ),
                  );
            })
          ],
        ),
      ),
    );
  }

  Widget _buttonSubmit({void Function()? onTap}) {
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
              color: AppColors.primary600,
            ),
            color: AppColors.primary600,
          ),
          child: Center(
            child: Text(
              'Create my account',
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

  Widget _toSignIn({required String text, void Function()? onPressed}) {
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
