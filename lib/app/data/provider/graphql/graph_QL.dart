import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  final String _url = ConfigGraphQl.httpLink;
  late GraphQLClient graphQLClient;
  final LocalDataSource localDataSource;

  GraphQLService({required this.localDataSource}) {
    _init();
  }

  _init({String? tokenParam}) async {
    try {
      String? token;
      if (tokenParam != null) {
        token = tokenParam;
      } else {
        token = await localDataSource.getToken();
      }

      final authLink = AuthLink(getToken: () async => 'Bearer $token');

      final Link httpLink = HttpLink(_url);
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
    } catch (e) {
      // ignore: avoid_print
      print('GraphQLService: $e');
    }
  }

  Future performQuery(String query, Map<String, dynamic>? variables) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      );
      final QueryResult result = await graphQLClient.query(options);

      return result.data;
    } catch (exception) {
      print('exception QUERY');
      print(exception);
    }
  }

  Future performMutation(
    String query,
    Map<String, dynamic> variables,
  ) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(query),
        variables: variables,
      );
      final QueryResult result = await graphQLClient.mutate(options);
      return result.data;
    } catch (exception) {
      // print('exception');
      // print(exception);
    }
  }

  Future performMutationWithToken(
    String query,
    Map<String, dynamic> variables,
    String? token,
  ) async {
    _init(tokenParam: token);
    try {
      final MutationOptions options = MutationOptions(
        document: gql(query),
        variables: variables,
      );
      final QueryResult result = await graphQLClient.mutate(options);
      return result.data;
    } catch (exception) {
      // print('exception');
      // print(exception);
    }
  }
}
