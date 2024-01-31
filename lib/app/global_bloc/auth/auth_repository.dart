part of 'auth_bloc.dart';

class AuthRepository {
  final GraphQLService graphQLClient;
  final LocalDataSource localDataSource;

  AuthRepository({
    required this.graphQLClient,
    required this.localDataSource,
  });

  Future<bool> login(LoginModel loginModel) async {
    final result = await graphQLClient.performMutation(
      ConfigGraphQl.loginMutation,
      {
        'loginInput': {
          'email': loginModel.email,
          'password': loginModel.password,
        }
      },
    );
    return true;
  }
}
