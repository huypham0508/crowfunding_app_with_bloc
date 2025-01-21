import 'dart:convert';

import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/conversation_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocal extends LocalDataSource {
  static DatabaseLocal? _instance;

  static DatabaseLocal getInstance(SharedPreferences sf) {
    if (_instance != null) return _instance!;
    _instance = DatabaseLocal._internal(sf);
    return _instance!;
  }

  DatabaseLocal._internal(super.sf);

  Future<List<Conversation>?> getRooms() async {
    final roomsJson = sf.getString(ConfigLocalData.ROOMS);
    if (roomsJson == null || roomsJson.isEmpty) return null;

    final List<dynamic> decoded = List<dynamic>.from(jsonDecode(roomsJson));
    return decoded.map((json) => Conversation.fromJson(json)).toList();
  }

  Future<void> addRoomItem(Conversation item) async {
    final rooms = await getRooms() ?? [];
    rooms.add(item);
    await sf.setString(
      ConfigLocalData.ROOMS,
      jsonEncode(
        rooms.map((e) => e.toJson()).toList(),
      ),
    );
  }

  Future<void> updateRoomItem(Conversation item) async {
    final rooms = await getRooms();
    if (rooms == null) return;

    final index = rooms.indexWhere((room) => room.id == item.id);
    if (index != -1) {
      rooms[index] = item;
      await sf.setString(
        ConfigLocalData.ROOMS,
        jsonEncode(
          rooms.map((e) => e.toJson()).toList(),
        ),
      );
    }
  }

  Future<void> deleteRoomItem(String id) async {
    final rooms = await getRooms();
    if (rooms == null) return;

    final updatedRooms = rooms.where((room) => room.id != id).toList();
    await sf.setString(
      ConfigLocalData.ROOMS,
      jsonEncode(
        updatedRooms.map((e) => e.toJson()).toList(),
      ),
    );
  }

  Future<void> deleteRooms() async {
    await sf.remove(ConfigLocalData.ROOMS);
  }
}
