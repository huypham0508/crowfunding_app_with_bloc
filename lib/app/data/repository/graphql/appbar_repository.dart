import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/search_friend_response.dart';

class AppBarRepository {
  final GraphQlAPIClient graphQLClient;

  AppBarRepository({
    required this.graphQLClient,
  });

  Future<SearchFriendResponse> searchFriend({String? email}) async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.findFriendByEmailQuery,
      variables: {"email": email},
    );
    if (result == null) {
      throw ApiException();
    }
    return SearchFriendResponse.fromJson(result['findFriendByEmail']);
  }
}
