abstract class AppString {
  static const String APP_TITLE = "Chat with me!";
}

abstract class CommonString {
  static const String ERROR = "Error!";
  static const String ERROR_MESSAGE = "Error! Please try again later";
  static const String CANCEL = "Cancel";
}

abstract class ConfigApi {
  // default
  static const String URL = "http://localhost:4000";
  static const String VERSION = "v1";
  //custom
  static const String API_VER1 = "${URL}/api/$VERSION";
  static const String GRAPH_QL_API_URL = "$URL/graphql/$VERSION";
  // endpoints
  static const String REGISTER_QUEUE = '/events/register';
  static const String GET_EVENTS = '/events';
}

abstract class ConfigLocalData {
  static const String USER_ID = "userId";
  static const String USER_NAME = "userName";
  static const String TOKEN = "token";
  static const String REFRESH_TOKEN = "refreshToken";

  static const String CONVERSATIONS = "conversations";
  static const String MESSAGES = "messages";
}
