import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/models/friend_model.dart';

class ListFriendResponse {
  bool? success;
  String? message;
  List<FriendModel>? data;

  ListFriendResponse({this.success, this.message, this.data});

  ListFriendResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FriendModel>[];
      json['data'].forEach((v) {
        data!.add(new FriendModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? email;
  String? avatar;
  String? id;
  String? userName;

  Data({this.email, this.avatar, this.id, this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    avatar = json['avatar'];
    id = json['id'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['userName'] = this.userName;
    return data;
  }
}
