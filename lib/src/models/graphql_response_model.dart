class GraphQlResponse {
  bool? success;
  String? message;
  int? status;

  GraphQlResponse({this.success, this.message, this.status});

  GraphQlResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
