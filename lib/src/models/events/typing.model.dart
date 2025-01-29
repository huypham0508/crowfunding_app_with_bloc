class UserTyping {
  final String userTyping;
  final String conversationId;

  UserTyping({
    required this.userTyping,
    required this.conversationId,
  });

  factory UserTyping.fromJson(Map<String, dynamic> json) {
    return UserTyping(
      userTyping: json['userTyping'] as String,
      conversationId: json['conversationId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userTyping': userTyping,
      'conversationId': conversationId,
    };
  }
}
