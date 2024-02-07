part of 'auth_bloc.dart';

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
}
