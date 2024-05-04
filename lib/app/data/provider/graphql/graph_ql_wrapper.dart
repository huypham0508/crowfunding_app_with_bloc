import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/refresh_token_response.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

abstract class GraphQlWrapper {
  final String _url = ConfigGraphQl.httpLink;
  late final LocalDataSource localDataSource;
  late GraphQLClient graphQLClient;
  String? _token;

  GraphQlWrapper({required this.localDataSource}) {
    _init();
  }

  set token(String value) {
    setHeader(tokenParam: value);
  }

  Future _init() async {
    try {
      var getToken = await localDataSource.getToken();
      setHeader(tokenParam: getToken);
    } catch (e) {
      print('GraphQlAPIClient: $e');
    }
  }

  Future setHeader({String? tokenParam}) async {
    print('set header');
    _token = tokenParam;
    final authLink = await AuthLink(getToken: () async => 'Bearer $_token');
    final Link httpLink = await HttpLink(_url);
    Link link = await authLink.concat(httpLink);
    graphQLClient = GraphQLClient(
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.networkOnly,
        ),
      ),
      cache: GraphQLCache(),
      link: link,
    );
  }

  Future _refreshToken() async {
    final dio = Dio();
    try {
      String? refreshToken = await localDataSource.getRefreshToken();
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["jwt-auth-cookie-name"] = refreshToken;
          return handler.next(options);
        },
      ));
      final response = await dio.get('${ConfigGraphQl.baseUrl}/refreshToken');
      RefreshTokenResponse data = RefreshTokenResponse.fromJson(response.data);
      if (data.success == true) {
        await localDataSource.saveToken(data.accessToken ?? '');
        print('refreshToken successfully');

        await setHeader(tokenParam: data.accessToken);
      }
    } catch (e) {
      throw Error();
    }
  }

  Future executeWithRetry<T>(
    Future<T> Function() action, {
    int retryCount = 3,
  }) async {
    try {
      var result = await action();
      if (result == null) {
        throw Exception();
      }
      return result;
    } catch (e) {
      if (retryCount > 0) {
        if (await localDataSource.getRefreshToken() == null) {
          return null;
        }
        await _refreshToken();

        if (retryCount == 1) {
          await localDataSource.deleteToken();
          await localDataSource.deleteRefreshToken();
          await localDataSource.deleteUserName();
          await localDataSource.deleteUserId();
        }
        return await executeWithRetry(action, retryCount: retryCount - 1);
      } else {
        return null;
      }
    }
  }
}
