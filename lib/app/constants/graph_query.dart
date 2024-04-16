// ignore: file_names
import 'package:crowfunding_app_with_bloc/app/constants/app_string.dart';

abstract class ConfigGraphQl {
  // httpLink
  static const String httpLink = ConfigApi.GRAPH_QL_APIURL;

  // query string
  static const String getAllUserQuery = r'''
    query getUser {
      getUser {
        userName
        email
        avatar
      }
    }
  ''';

  // mutation string
  static const String loginMutation = '''
    mutation login(\$loginInput: LoginInput!) {
        login(loginInput: \$loginInput) {
          success
          message
          code
          accessToken
    }
  }
  ''';

  static const String registerMutation = '''
    mutation register(\$registerInput: RegisterInput!) {
        register(registerInput: \$registerInput) {
          success
          message
          code
      }
  }
  ''';

  static const String getOtpMutation = '''
    mutation ForgotPassword(\$email: String!) {
      forgotPassword(email: \$email) {
          message
          success
          code
      }
  }
  ''';

  static const String submitOTPMutation = '''
    mutation SubmitOTP(\$otp: String!, \$email: String!) {
      submitOTP(otp: \$otp, email: \$email) {
          success
          code
          message
          accessToken
      }
  }
  ''';

  static const String resetPasswordMutation = '''
    mutation ResetPassword(\$newPassword: String!) {
      resetPassword(newPassword: \$newPassword) {
        code
        message
        success
      }
  }
  ''';
}
