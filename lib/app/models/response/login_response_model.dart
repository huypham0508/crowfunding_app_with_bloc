class LoginResponse {
  bool? success;
  String? message;

  LoginResponse({
    this.success,
    this.message,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
