import 'package:crowfunding_app_with_bloc/src/models/graphql_response_model.dart';

class Role {
  final String id;
  final String name;
  final List<String> permissions;

  Role({required this.id, required this.name, required this.permissions});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      permissions: List<String>.from(json['permissions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
    };
  }
}

class Participant {
  final String userName;
  final String id;
  final String email;
  final String? avatar;
  final Role role;

  Participant({
    required this.userName,
    required this.id,
    required this.email,
    this.avatar,
    required this.role,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userName: json['userName'],
      id: json['id'],
      email: json['email'],
      avatar: json['avatar'],
      role: Role.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'id': id,
      'email': email,
      'avatar': avatar,
      'role': role.toJson(),
    };
  }
}

class Sender {
  final String id;
  final String email;

  Sender({required this.id, required this.email});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}

class MaxMessage {
  final String id;
  final String content;
  final Sender sender;
  final DateTime createdAt;

  MaxMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.createdAt,
  });

  factory MaxMessage.fromJson(Map<String, dynamic> json) {
    return MaxMessage(
      id: json['id'],
      content: json['content'],
      sender: Sender.fromJson(json['sender']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Conversation {
  final String id;
  final String name;
  final List<Participant> participants;
  final MaxMessage maxMessage;
  final bool isTyping;

  Conversation({
    required this.id,
    required this.name,
    required this.participants,
    required this.maxMessage,
    this.isTyping = false,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      name: json['name'],
      participants: (json['participants'] as List)
          .map((participant) => Participant.fromJson(participant))
          .toList(),
      maxMessage: MaxMessage.fromJson(json['maxMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'participants': participants.map((p) => p.toJson()).toList(),
      'maxMessage': maxMessage.toJson(),
    };
  }
}

class ConversationsResponse extends GraphQlResponse {
  final List<Conversation> conversations;
  ConversationsResponse({
    required this.conversations,
    bool? success,
    String? message,
    int? status,
  }) : super(success: success, message: message, status: status);

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) {
    return ConversationsResponse(
      conversations: (json['data'] as List)
          .map(
            (conversation) => Conversation.fromJson(conversation),
          )
          .toList(),
      success: json['success'],
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['success'] = success;
    data['message'] = message;
    data['status'] = status;
    data['conversations'] = conversations
        .map(
          (conversation) => conversation.toJson(),
        )
        .toList();
    return data;
  }
}
