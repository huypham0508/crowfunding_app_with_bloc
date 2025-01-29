import 'package:crowfunding_app_with_bloc/src/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/src/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/src/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/src/models/search_friend.model.dart';
import 'package:crowfunding_app_with_bloc/src/modules/home/index.dart';

class AppBarRepository extends FriendRepository {
  final GraphQlAPIClient graphQLClient;

  AppBarRepository({required this.graphQLClient})
      : super(graphQLClient: graphQLClient);

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
