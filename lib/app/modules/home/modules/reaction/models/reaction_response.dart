part of '../../../index.dart';

class ReactionResponse {
  int? code;
  String? message;
  bool? success;
  List<ReactionModel>? data;

  ReactionResponse({this.code, this.message, this.success, this.data});

  ReactionResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <ReactionModel>[];
      json['data'].forEach((v) {
        data!.add(new ReactionModel.fromJson(v));
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

class ReactionModel {
  String? id;
  String? imageURL;
  int? count;
  String? name;

  ReactionModel({this.id, this.imageURL, this.count, this.name});

  ReactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageURL = json['imageURL'];
    count = json['count'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageURL'] = this.imageURL;
    data['count'] = this.count;
    data['name'] = this.name;
    return data;
  }
}
