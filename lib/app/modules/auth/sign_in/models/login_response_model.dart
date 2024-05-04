class SignInResponse {
  bool? success;
  String? message;

  SignInResponse({
    this.success,
    this.message,
  });

  SignInResponse.fromJson(Map<String, dynamic> json) {
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
