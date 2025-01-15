part of '../../index.dart';

class SignInView extends StatelessWidget {
  final AuthBloc authBloc;
  const SignInView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return FadeMoveLeftToRight(
      child: BlocProvider(
        create: (context) {
          return SignInBloc(
            biometric: BiometricService(),
            authRepository: AuthRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
              localDataSource: context.read<LocalDataSource>(),
            ),
          );
        },
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: ((context, state) {
            switch (state.status) {
              case SignInStatus.loading:
                showDialog(
                  context: context,
                  barrierDismissible: false,
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
            return ContainerSignIn(
              children: [
                AuthTitle(
                  titleString: FlutterI18n.translate(
                    context,
                    "auth.sign_in.title",
                  ),
                ),
                _question(context),
                GlobalStyles.sizedBoxHeight_24,
                LoginGoogleButton(),
                ..._inputs(state, context),
                Row(
                  children: [
                    // IconButton(onPressed: () {}, icon: Icon(Icons.fingerprint)),
                    Spacer(),
                    ToPage(
                      text: 'Forgot password',
                      onPressed: () {
                        authBloc.add(
                          SwitchAuthPageEvent(
                            authPage: AuthPage.ForgotPw,
                          ),
                        );
                      },
                    )
                  ],
                ),
                GlobalStyles.sizedBoxHeight_24,
                ButtonAuthCustom(
                  context: context,
                  text: FlutterI18n.translate(
                    context,
                    "auth.sign_in.title",
                  ),
                  onTap: () {
                    context.read<SignInBloc>().add(
                          StartedLoginEvent(
                            context: context,
                            type: StartedLoginEventEnum.submitted,
                            loginModel: LoginModel(
                              email: state.signInEmailSController.text,
                              password: state.signInPasswordController.text,
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

  Widget _question(BuildContext context) {
    return Row(
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
        ToPage(
          text: " " +
              FlutterI18n.translate(
                context,
                "auth.sign_in.sign_up",
              ),
          onPressed: () {
            authBloc.add(
              SwitchAuthPageEvent(
                authPage: AuthPage.signUp,
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _inputs(SignInState signInState, BuildContext context) {
    return [
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
    ];
  }
}

class ContainerSignIn extends StatelessWidget {
  const ContainerSignIn({super.key, required this.children});

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
