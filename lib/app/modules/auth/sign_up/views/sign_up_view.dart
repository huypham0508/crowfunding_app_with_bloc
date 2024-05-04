import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/models/auth_models.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_button_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/auth_title.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/error_message.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/input_custom.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/login_with_google.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/widgets/to_page.dart';
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
    return FadeMoveRightToLeft(
      child: BlocProvider(
        create: (context) {
          return SignUpBloc(
            authRepository: AuthRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
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
                    barrierDismissible: false,
                    barrierColor: AppColors.black300.withOpacity(0.2),
                    builder: (context) => Utils.loading(loading: 'Loading...'));
                break;
              case SignUpStatus.registerSuccess:
                Utils.dialogNotification(
                  context,
                  'Registered successfully!',
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
          }),
          builder: (context, state) {
            return ContainerSignUp(
              children: [
                AuthTitle(
                  titleString: FlutterI18n.translate(
                    context,
                    "auth.sign_up.title",
                  ),
                ),
                _question(context),
                GlobalStyles.sizedBoxHeight_24,
                LoginGoogleButton(),
                ..._inputs(state, context),
                ButtonAuthCustom(
                  context: context,
                  text: 'Create my account',
                  onTap: () {
                    context.read<SignUpBloc>().add(
                          StartedSignUpEvent(
                            context: context,
                            type: StartedSignUpEventEnum.submitted,
                            registerModel: RegisterModel(
                              username: state.signUpUsernameController.text,
                              email: state.signUpEmailSController.text,
                              password: state.signUpPasswordController.text,
                              confirmPw: state.signUpConfirmPwController.text,
                            ),
                          ),
                        );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Row _question(BuildContext context) {
    return Row(
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
        ToPage(
          text: " " + FlutterI18n.translate(context, "auth.sign_up.sign_in"),
          onPressed: () {
            authBloc.add(
              SwitchAuthPageEvent(
                authPage: AuthPage.signIn,
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _inputs(
    SignUpState signUpState,
    BuildContext context,
  ) {
    return [
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
    ];
  }
}

class ContainerSignUp extends StatelessWidget {
  const ContainerSignUp({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
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
          children: children,
        ),
      ),
    );
  }
}
