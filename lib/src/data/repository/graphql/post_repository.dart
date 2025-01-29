import 'package:crowfunding_app_with_bloc/src/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/src/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/src/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/src/models/graphql_response_model.dart';
import 'package:crowfunding_app_with_bloc/src/modules/home/index.dart';

class PostRepository {
  final GraphQlAPIClient graphQLClient;

  PostRepository({
    required this.graphQLClient,
  });

  Future<PostResponse> getAllPosts({
    int pageSize = 1,
    int pageNumber = 10,
  }) async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getAllPostsQuery,
      variables: {"pageNumber": pageNumber, "pageSize": pageSize},
    );
    if (result == null) {
      throw ApiException();
    }
    return PostResponse.fromJson(result['allPosts']);
  }

  Future<PostResponse> getPostsYourFriend({
    int pageSize = 1,
    int pageNumber = 10,
  }) async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getPostsYourFriendQuery,
      variables: {"pageNumber": pageNumber, "pageSize": pageSize},
    );
    if (result == null) {
      throw ApiException();
    }

    return PostResponse.fromJson(result['postsOfFriends']);
  }

  Future<PostResponse> getYourPosts({
    int pageSize = 1,
    int pageNumber = 10,
  }) async {
    final result = await graphQLClient.performQuery(
      query: ConfigGraphQl.getYourPostsQuery,
      variables: {"pageNumber": pageNumber, "pageSize": pageSize},
    );
    if (result == null) {
      throw ApiException();
    }

    return PostResponse.fromJson(result['yourPosts']);
  }

  Future<GraphQlResponse> createPost({
    required String desc,
    required String imageUrl,
  }) async {
    final result = await graphQLClient.performMutation(
      query: ConfigGraphQl.createPostMutation,
      variables: {
        "postInput": {
          "description": desc,
          "imageUrl": imageUrl,
        }
      },
    );
    if (result == null) {
      throw ApiException();
    }

    return GraphQlResponse.fromJson(result['createPost']);
  }
}
