part of '../../../global_bloc/auth/auth_bloc.dart';

class AuthRepository {
  final GraphQLService graphQLClient;
  final LocalDataSource localDataSource;

  AuthRepository({
    required this.graphQLClient,
    required this.localDataSource,
  });

  Future<LoginResponse> login(LoginModel payload) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.loginMutation,
      {
        'loginInput': {
          'email': payload.email,
          'password': payload.password,
        }
      },
    );
    if (result['login']['success'] == true) {
      localDataSource.saveToken(result['login']['accessToken']);
    }
    return LoginResponse.fromJson(result['login']);
  }

  Future<RegisterResponse> register(RegisterModel payload) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.registerMutation,
      {
        'registerInput': {
          'userName': payload.username,
          'email': payload.email,
          'password': payload.password,
        }
      },
    );
    return RegisterResponse.fromJson(result['register']);
  }

  Future<ForgotPwResponse> getOtpWithEmail(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.getOtpMutation,
      {"email": payload.email},
    );
    return ForgotPwResponse.fromJson(result['forgotPassword']);
  }

  Future<ForgotPwResponse> submitOTP(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.submitOTPMutation,
      {"email": payload.email, "otp": payload.OTP},
    );

    return ForgotPwResponse.fromJson(result?['submitOTP'] ?? '');
  }

  Future<ForgotPwResponse> resetPassword(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutationWithToken(
      ConfigGraphQl.resetPasswordMutation,
      {"newPassword": payload.password},
      payload.token,
    );

    return ForgotPwResponse.fromJson(result['resetPassword']);
  }
}
