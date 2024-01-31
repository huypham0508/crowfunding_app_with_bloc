import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final GraphQLClient _graphQLClient;
  const GraphQLService(this._graphQLClient);

  Future<QueryResult> performQuery(
    String query,
  ) async {
    QueryOptions options = QueryOptions(document: gql(query));

    final QueryResult result = await _graphQLClient.query(options);
    return result;
  }

  Future<QueryResult> performMutation(
    String query,
    Map<String, dynamic> variables,
  ) async {
    MutationOptions options = MutationOptions(
      document: gql(query),
      variables: variables,
    );

    final QueryResult result = await _graphQLClient.mutate(options);
    return result;
  }
}
