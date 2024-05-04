class ForgotPwResponse {
  bool? success;
  String? message;
  int? code;
  String? accessToken;

  ForgotPwResponse({this.success, this.message, this.code, this.accessToken});

  ForgotPwResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
