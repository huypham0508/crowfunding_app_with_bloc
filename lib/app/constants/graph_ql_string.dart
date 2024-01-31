// ignore: file_names
import 'package:crowfunding_app_with_bloc/app/constants/app_string.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ConfigGraphQl {
  // httpLink
  static final HttpLink httpLink = HttpLink(ConfigApi.GRAPH_QL_APIURL);

  // query string
  static const String getUserQuery = "";

  // mutation string
  static const String loginMutation = """
    mutation login(\$loginInput: LoginInput!) {
        login(loginInput: \$loginInput) {
        success
        message
        code
        accessToken
    }
  """;
}
