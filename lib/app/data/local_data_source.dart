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

  Future<void> saveToken(String token) async {
    await sf.setString('token', token);
  }

  Future<String?> getToken() async {
    return sf.getString('token');
  }

  Future<void> deleteToken() async {
    await sf.remove('token');
  }

  String? getThemeMode() {
    return sf.getString('themeMode');
  }

  Future<String?> saveThemeMode(String token) async {
    return sf.getString('themeMode');
  }

  Future<void> deleteThemeMode() async {
    await sf.remove('themeMode');
  }
}
