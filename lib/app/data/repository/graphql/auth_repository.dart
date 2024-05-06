part of '../../../global_bloc/auth/auth_bloc.dart';

class AuthRepository {
  final GraphQlAPIClient graphQLClient;
  final LocalDataSource localDataSource;

  AuthRepository({
    required this.graphQLClient,
    required this.localDataSource,
  });

  Future<SignInResponse> login(LoginModel payload) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.loginMutation,
      variables: {
        'loginInput': {
          'email': payload.email,
          'password': payload.password,
        }
      },
    );
    if (result == null) {
      throw ApiException();
    }
    if (result['login']['success'] == true) {
      localDataSource.saveToken(result['login']!['accessToken'] ?? '');
      localDataSource.saveRefreshToken(result['login']!['refreshToken'] ?? '');
      localDataSource.saveUserId(result['login']!['user']!['id']);
      graphQLClient.token = result['login']!['accessToken'] ?? '';
    }

    return SignInResponse.fromJson(result['login'] ?? '');
  }

  Future<SignUpResponse> register(RegisterModel payload) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.registerMutation,
      variables: {
        'registerInput': {
          'userName': payload.username,
          'email': payload.email,
          'password': payload.password,
        }
      },
    );

    if (result == null) {
      throw ApiException();
    }

    return SignUpResponse.fromJson(result['register']);
  }

  Future<ForgotPwResponse> getOtpWithEmail(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.getOtpMutation,
      variables: {"email": payload.email},
    );

    if (result == null) {
      throw ApiException();
    }

    return ForgotPwResponse.fromJson(result['forgotPassword']);
  }

  Future<ForgotPwResponse> submitOTP(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.submitOTPMutation,
      variables: {"email": payload.email, "otp": payload.OTP},
    );
    if (result == null) {
      throw ApiException();
    }

    return ForgotPwResponse.fromJson(result['submitOTP'] ?? '');
  }

  Future<ForgotPwResponse> resetPassword(ForgotPwModel payload) async {
    final result = await graphQLClient.performMutationWithToken(
      query: ConfigGraphQl.resetPasswordMutation,
      variables: {"newPassword": payload.password},
      token: payload.token,
    );
    if (result == null) {
      throw ApiException();
    }

    return ForgotPwResponse.fromJson(result['resetPassword']);
  }

  Future logout() async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.logoutMutation,
      variables: {"logoutId": localDataSource.getUserId()},
    );
    print(result);
  }
}
