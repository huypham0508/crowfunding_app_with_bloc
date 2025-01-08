import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  LocalDataSource(this.sf);

  final SharedPreferences sf;

  Future<void> saveUserName(String userName) async {
    await sf.setString('userName', userName);
  }

  Future<String?> getUserName() async {
    return sf.getString('userName');
  }

  Future<void> deleteUserName() async {
    await sf.remove('userName');
  }

  Future<void> saveUserId(String userId) async {
    await sf.setString('userId', userId);
  }

  Future<String?> getUserId() async {
    return sf.getString('userId');
  }

  Future<void> deleteUserId() async {
    await sf.remove('userId');
  }

  Future<void> saveToken(String token) async {
    await sf.setString('token', token);
  }

  Future<String?> getToken() async {
    return sf.getString('token');
  }

  Future<void> deleteToken() async {
    await sf.remove('token');
  }

  Future<void> saveRefreshToken(String token) async {
    await sf.setString('refreshToken', token);
  }

  Future<String?> getRefreshToken() async {
    return sf.getString('refreshToken');
  }

  Future<void> deleteRefreshToken() async {
    await sf.remove('refreshToken');
  }

  Future<void> saveQueueId(String token) async {
    await sf.setString('queueID', token);
  }

  Future<String?> getQueueId() async {
    return sf.getString('queueID');
  }

  Future<void> deleteQueueId() async {
    await sf.remove('queueID');
  }

  Future<void> saveLastEventId(int id) async {
    await sf.setInt('LastEventId', id);
  }

  Future<int?> getLastEventId() async {
    return sf.getInt('LastEventId');
  }

  Future<void> deleteLastEventId() async {
    await sf.remove('LastEventId');
  }
}
