class RefreshTokenResponse {
  bool? success;
  String? accessToken;
  String? refreshToken;

  RefreshTokenResponse({this.success});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

  @override
  String toString() {
    return 'success: $success; \n accessToken: $accessToken; \n refreshToken: $refreshToken';
  }
}
