part of '../index.dart';

class PostResponse {
  int? code;
  String? message;
  bool? success;
  List<PostsData>? data;

  PostResponse({this.code, this.message, this.success, this.data});

  PostResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <PostsData>[];
      json['data'].forEach((v) {
        data!.add(new PostsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostsData {
  String? imageUrl;
  String? id;
  String? description;
  User? user;
  List<ReactionModel>? reactions;

  PostsData({
    this.imageUrl,
    this.id,
    this.user,
    this.reactions,
    this.description,
  });

  PostsData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    description = json['description'];
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['reactions'] != null) {
      reactions = <ReactionModel>[];
      json['reactions'].forEach((v) {
        reactions!.add(new ReactionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? email;
  String? avatar;
  String? userName;

  User({this.email, this.avatar, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    avatar = json['avatar'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['userName'] = this.userName;
    return data;
  }
}
