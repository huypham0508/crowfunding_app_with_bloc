import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class LotoFirebaseDatabase {
  final DatabaseReference _refData;
  final DatabaseReference _refUsers;

  LotoFirebaseDatabase({
    required DatabaseReference refData,
    required DatabaseReference refUsers,
  })  : _refData = refData,
        _refUsers = refUsers;

  Future listenData(Function(DatabaseEvent event) onListener) async {
    return _refData.onValue.listen((event) => onListener(event));
  }

  Future listenUsers(Function(DatabaseEvent event) onListener) async {
    return _refUsers.onValue.listen((event) => onListener(event));
  }

  Future updateUserName(String userName, List oldData) async {
    String newListUsers = jsonEncode(oldData..add(userName));
    return _refUsers.set(newListUsers);
  }
}
