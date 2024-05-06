class FriendModel {
  String? email;
  String? avatar;
  String? id;
  String? userName;

  FriendModel({this.email, this.avatar, this.id, this.userName});

  FriendModel.fromJson(Map<String, dynamic> json) {
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
