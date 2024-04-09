part of '../../../global_bloc/auth/auth_bloc.dart';

class AuthRepository {
  final GraphQLService graphQLClient;
  final LocalDataSource localDataSource;

  AuthRepository({
    required this.graphQLClient,
    required this.localDataSource,
  });

  Future<LoginResponse> login(LoginModel loginModel) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.loginMutation,
      {
        'loginInput': {
          'email': loginModel.email,
          'password': loginModel.password,
        }
      },
    );
    if (result['login']['success'] == true) {
      localDataSource.saveToken(result['login']['accessToken']);
    }
    return LoginResponse.fromJson(result['login']);
  }

  Future<RegisterResponse> register(RegisterModel registerModel) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.registerMutation,
      {
        'registerInput': {
          'userName': registerModel.username,
          'email': registerModel.email,
          'password': registerModel.password,
        }
      },
    );
    return RegisterResponse.fromJson(result['register']);
  }
}
