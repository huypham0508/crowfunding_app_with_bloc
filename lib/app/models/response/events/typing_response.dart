class UserTyping {
  final String userTyping;
  final String roomId;

  UserTyping({
    required this.userTyping,
    required this.roomId,
  });

  factory UserTyping.fromJson(Map<String, dynamic> json) {
    return UserTyping(
      userTyping: json['userTyping'] as String,
      roomId: json['roomId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userTyping': userTyping,
      'roomId': roomId,
    };
  }
}
