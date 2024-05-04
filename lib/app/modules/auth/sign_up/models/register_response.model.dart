class SignUpResponse {
  bool? success;
  String? message;
  int? code;

  SignUpResponse({this.success, this.message, this.code});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
