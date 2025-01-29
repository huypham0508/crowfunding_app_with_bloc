import 'dart:async';

import 'package:crowfunding_app_with_bloc/src/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/src/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/src/models/refresh_token.model.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

abstract class ProviderWrapper {
  String? _token;
  late GraphQLClient graphQLClient;
  final String _url = ConfigGraphQl.httpLink;
  late final LocalDataSource localDataSource;

  static const int maxRetryAttempts = 1;
  int _retryAttempts = 0;

  ProviderWrapper({required this.localDataSource}) {
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
    _token = tokenParam;
    final authLink = await AuthLink(getToken: () async => 'Bearer $_token');
    final Link httpLink = await HttpLink(_url);
    Link link = authLink.concat(httpLink);
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
        await localDataSource.saveRefreshToken(data.refreshToken ?? '');
        await setHeader(tokenParam: data.accessToken);
      }
    } catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }

  Future<T?> executeWithRetry<T>(
    Future<T> Function() action, {
    int retryCount = maxRetryAttempts,
  }) async {
    try {
      var result = await action();
      _retryAttempts = 0;
      return result;
    } catch (e) {
      _retryAttempts++;
      if (_retryAttempts >= maxRetryAttempts) {
        return null;
      }
      if (await localDataSource.getRefreshToken() == null) {
        return null;
      }
      await _refreshToken();
      return await executeWithRetry(action, retryCount: retryCount - 1);
    }
  }
}
