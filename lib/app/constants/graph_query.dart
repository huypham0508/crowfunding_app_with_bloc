// ignore: file_names
import 'package:crowfunding_app_with_bloc/app/constants/app_string.dart';

abstract class ConfigGraphQl {
  // httpLink
  static const String httpLink = ConfigApi.GRAPH_QL_APIURL;
  static const String baseUrl = ConfigApi.BASEURL;

  // query string
  static const String hello = r'''
    query hello {
      hello
  }
  ''';

  static const String getAllUserQuery = r'''
    query getUser {
      getUser {
        userName
        email
        avatar
      }
    }
  ''';

  static const String getReactionsQuery = r'''
    query Reactions {
      reactions {
        code
        message
        success
        data {
          id
          imageURL
          count
          name
        }
      }
    }
  ''';

  static const String getAllPostsQuery = '''
    query AllPosts(\$pageNumber: Float!, \$pageSize: Float!) {
        allPosts(pageNumber: \$pageNumber, pageSize: \$pageSize) {
            code
            message
            success
            data {
                id
                description
                imageUrl
                user {
                    email
                    avatar
                    userName
                }
            }
        }
  }
  ''';

  static const String getPostsYourFriendQuery = '''
    query PostsOfFriends(\$pageNumber: Float!, \$pageSize: Float!) {
      postsOfFriends(pageNumber: \$pageNumber, pageSize: \$pageSize) {
        code
        message
        success
        data {
          id
          description
          imageUrl
          user {
            id
            email
            avatar
            userName
          }
        }
      }
    }
  ''';

  static const String getYourPostsQuery = '''
  query YourPosts(\$pageNumber: Float!, \$pageSize: Float!) {
    yourPosts(pageNumber: \$pageNumber, pageSize: \$pageSize) {
      code
      message
      success
      data {
        id
        imageUrl
        description
        reactions {
          imageURL
          count
          name
        }
      }
    }
  }
  ''';

  static const String getFriendsQuery = '''
    query GetFriendList {
      getFriendList {
        message
        success
        data {
          avatar
          email
          userName
        }
      }
  }
  ''';

  static const String findFriendByEmailQuery = '''
   query FindFriendByEmail(\$email: String!) {
      findFriendByEmail(email: \$email) {
        message
        success
        data {
          userName
          email
          avatar
          status
        }
      }
  }
  ''';

  static const String getFriendsRequestQuery = '''
    query GetFriendRequests {
      getFriendRequests {
        message
        success
        data {
          id
          avatar
          email
          userName
        }
      }
  }
  ''';

  // mutation string
  static const String loginMutation = '''
    mutation login(\$loginInput: LoginInput!) {
        login(loginInput: \$loginInput) {
          success
          message
          code
          accessToken
          refreshToken
          user {
            id
          }
    }
  }
  ''';

  static const String registerMutation = '''
    mutation register(\$registerInput: RegisterInput!) {
        register(registerInput: \$registerInput) {
          success
          message
          code
      }
  }
  ''';

  static const String getOtpMutation = '''
    mutation ForgotPassword(\$email: String!) {
      forgotPassword(email: \$email) {
          message
          success
          code
      }
  }
  ''';

  static const String submitOTPMutation = '''
    mutation SubmitOTP(\$otp: String!, \$email: String!) {
      submitOTP(otp: \$otp, email: \$email) {
          success
          code
          message
          accessToken
      }
  }
  ''';

  static const String resetPasswordMutation = '''
    mutation ResetPassword(\$newPassword: String!) {
      resetPassword(newPassword: \$newPassword) {
        code
        message
        success
      }
  }
  ''';

  static const String logoutMutation = '''
    mutation logout(\$logoutId: ID!) {logout(id: \$logoutId) {
      code
      success
      message
    }
  }
  ''';

  static const String incrementMutation = '''
    mutation IncreaseReactionCount(\$reactName: String!, \$postId: String!) {
      increaseReactionCount(reactName: \$reactName, postId: \$postId) {
        code
        message
        success
      }
    }
  ''';

  static const String decrementMutation = '''
    mutation DecreaseReactionCount(\$reactName: String!, \$postId: String!) {
      decreaseReactionCount(reactName: \$reactName, postId: \$postId) {
        code
        message
        success
      }
    }
  ''';

  static const String createPostMutation = '''
    mutation CreatePost(\$postInput: CreatePostInput!) {
      createPost(postInput: \$postInput) {
        code
        success
        message
      }
  }
  ''';

  static const String sendFriendRequestMutation = '''
    mutation CreatePost(\$postInput: CreatePostInput!) {
      createPost(postInput: \$postInput) {
        code
        success
        message
      }
  }
  ''';

  static const String rejectedRequestMutation = '''
    mutation RejectedFriendRequest(\$requestId: String!) {
      rejectedFriendRequest(requestId: \$requestId) {
        message
        success
      }
  }
  ''';

  static const String acceptRequestMutation = '''
    mutation AcceptFriendRequest(\$requestId: String!) {
      acceptFriendRequest(requestId: \$requestId) {
        message
        success
      }
  }
  ''';
}
