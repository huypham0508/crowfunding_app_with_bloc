class RegisterResponse {
  bool? success;
  String? message;
  int? code;

  RegisterResponse({this.success, this.message, this.code});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
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
