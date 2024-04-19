import 'dart:async';

import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/refresh_token_response.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  final String _url = ConfigGraphQl.httpLink;
  late GraphQLClient graphQLClient;
  final LocalDataSource localDataSource;
  String? _token;

  GraphQLService._({required this.localDataSource}) {
    _init();
  }

  static GraphQLService? _instance;

  static GraphQLService getInstance({
    required LocalDataSource localDataSource,
  }) {
    _instance ??= GraphQLService._(localDataSource: localDataSource);
    return _instance!;
  }

  set token(String value) {
    _setHeader(tokenParam: value);
  }

  Future _init() async {
    try {
      var getToken = await localDataSource.getToken();
      _setHeader(tokenParam: getToken);
    } catch (e) {
      print('GraphQLService: $e');
    }
  }

  Future _setHeader({String? tokenParam}) async {
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
        await localDataSource.saveRefreshToken(data.refreshToken ?? '');
        await localDataSource.saveToken(data.accessToken ?? '');
        print('refreshToken successfully');

        await _setHeader(tokenParam: data.accessToken);
      }
    } catch (e) {
      throw Error();
    }
  }

  Future _executeWithRetry<T>(
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
        return await _executeWithRetry(action, retryCount: retryCount - 1);
      } else {
        return null;
      }
    }
  }

  Future performQuery({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    return await _executeWithRetry(() async {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      );
      final QueryResult result = await graphQLClient.query(options);
      return result.data;
    });
  }

  Future performMutation({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    return await _executeWithRetry(() async {
      final MutationOptions options = MutationOptions(
        document: gql(query),
        variables: variables,
      );
      final QueryResult result = await graphQLClient.mutate(options);

      return result.data;
    });
  }

  Future performMutationWithToken({
    required String query,
    required Map<String, dynamic> variables,
    String? token,
  }) async {
    await _setHeader(tokenParam: token);
    return await _executeWithRetry(() async {
      final MutationOptions options = MutationOptions(
        document: gql(query),
        variables: variables,
      );
      final QueryResult result = await graphQLClient.mutate(options);
      return result.data;
    });
  }
}
