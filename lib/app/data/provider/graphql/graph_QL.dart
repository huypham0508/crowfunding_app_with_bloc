import 'dart:async';

import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/provider_wrapper.dart';
import 'package:graphql/client.dart';

class GraphQlAPIClient extends ProviderWrapper {
  GraphQlAPIClient._({
    required LocalDataSource localDataSource,
  }) : super(localDataSource: localDataSource);

  static GraphQlAPIClient? _instance;

  Future<Map<String, dynamic>?> performQuery({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    return await super.executeWithRetry<Map<String, dynamic>?>(() async {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      );
      final QueryResult result = await graphQLClient.query(options);
      return result.data;
    });
  }

  Future<Map<String, dynamic>?> performMutation({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    return await super.executeWithRetry<Map<String, dynamic>?>(() async {
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
    await setHeader(tokenParam: token);
    try {
      final MutationOptions options = MutationOptions(
        document: gql(query),
        variables: variables,
      );
      final QueryResult result = await graphQLClient.mutate(options);
      return result.data;
    } catch (e) {
      return null;
    }
  }

  static GraphQlAPIClient getInstance({
    required LocalDataSource localDataSource,
  }) {
    _instance ??= GraphQlAPIClient._(localDataSource: localDataSource);
    return _instance!;
  }
}
