class SearchFriendResponse {
  String? message;
  bool? success;
  List<FriendResult>? data;

  SearchFriendResponse({this.message, this.success, this.data});

  SearchFriendResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <FriendResult>[];
      json['data'].forEach((v) {
        data!.add(new FriendResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SearchFriendResponse{message: $message, success: $success, data: ${data.toString()}}';
  }
}

class FriendResult {
  String? userName;
  String? email;
  String? avatar;
  String? status;

  FriendResult({this.userName, this.email, this.avatar, this.status});

  FriendResult.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    avatar = json['avatar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'FriendResult{userName: $userName, email: $email, avatar: $avatar, status: $status}';
  }
}
