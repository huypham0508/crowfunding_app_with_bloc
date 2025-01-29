import 'dart:convert';

import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/src/models/conversation.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocal extends LocalDataSource {
  static DatabaseLocal? _instance;

  static DatabaseLocal getInstance(SharedPreferences sf) {
    if (_instance != null) return _instance!;
    _instance = DatabaseLocal._internal(sf);
    return _instance!;
  }

  DatabaseLocal._internal(super.sf);

  Future<List<Conversation>?> getConversations() async {
    final conversationsJson = sf.getString(ConfigLocalData.CONVERSATIONS);
    if (conversationsJson == null || conversationsJson.isEmpty) return null;

    final List<dynamic> decoded = List<dynamic>.from(
      jsonDecode(conversationsJson),
    );
    return decoded.map((json) => Conversation.fromJson(json)).toList();
  }

  Future<void> addConversationItem(Conversation item) async {
    final conversations = await getConversations() ?? [];
    conversations.add(item);
    await sf.setString(
      ConfigLocalData.CONVERSATIONS,
      jsonEncode(
        conversations.map((e) => e.toJson()).toList(),
      ),
    );
  }

  Future<void> updateConversationItem(Conversation item) async {
    final conversations = await getConversations();
    if (conversations == null) return;

    final index =
        conversations.indexWhere((conversation) => conversation.id == item.id);
    if (index != -1) {
      conversations[index] = item;
      await sf.setString(
        ConfigLocalData.CONVERSATIONS,
        jsonEncode(
          conversations.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  Future<void> deleteConversationItem(String id) async {
    final conversations = await getConversations();
    if (conversations == null) return;

    final updatedConversations =
        conversations.where((conversation) => conversation.id != id).toList();
    await sf.setString(
      ConfigLocalData.CONVERSATIONS,
      jsonEncode(
        updatedConversations.map((e) => e.toJson()).toList(),
      ),
    );
  }

  Future<void> deleteConversations() async {
    await sf.remove(ConfigLocalData.CONVERSATIONS);
  }
}
