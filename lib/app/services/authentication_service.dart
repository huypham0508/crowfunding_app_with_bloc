import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  final _storage = const FlutterSecureStorage();

  Future<String> read(String key) async {
    final result = await _storage.read(key: key);
    return result != null ? jsonDecode(result) : '';
  }

  write(String key, dynamic value) {
    _storage.write(key: key, value: jsonEncode(value));
  }

  Future<void> clearStorage() async {
    _storage.delete(key: 'pin');
  }
}
