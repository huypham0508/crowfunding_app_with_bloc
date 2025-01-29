import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  LocalDataSource(this.sf);

  final SharedPreferences sf;

  Future<void> saveUserName(String userName) async {
    await sf.setString(ConfigLocalData.USER_NAME, userName);
  }

  Future<String?> getUserName() async {
    return sf.getString(ConfigLocalData.USER_NAME);
  }

  Future<void> deleteUserName() async {
    await sf.remove(ConfigLocalData.USER_NAME);
  }

  Future<void> saveUserId(String userId) async {
    await sf.setString(ConfigLocalData.USER_ID, userId);
  }

  Future<String?> getUserId() async {
    return sf.getString(ConfigLocalData.USER_ID);
  }

  Future<void> deleteUserId() async {
    await sf.remove(ConfigLocalData.USER_ID);
  }

  Future<void> saveToken(String token) async {
    await sf.setString(ConfigLocalData.TOKEN, token);
  }

  Future<String?> getToken() async {
    return sf.getString(ConfigLocalData.TOKEN);
  }

  Future<void> deleteToken() async {
    await sf.remove(ConfigLocalData.TOKEN);
  }

  Future<void> saveRefreshToken(String token) async {
    await sf.setString(ConfigLocalData.REFRESH_TOKEN, token);
  }

  Future<String?> getRefreshToken() async {
    return sf.getString(ConfigLocalData.REFRESH_TOKEN);
  }

  Future<void> deleteRefreshToken() async {
    await sf.remove(ConfigLocalData.REFRESH_TOKEN);
  }

  // Future<void> saveEmailsOtp(Map emails) async {
  //   String jsonEmails = jsonEncode(emails);
  //   await sf.setString('EmailsOtp', jsonEmails);
  // }

  // Future<Map?> getEmailsOtp() async {
  //   String? emails = await sf.getString('EmailsOtp');
  //   if (emails != null) {
  //     Map<String, dynamic> map = jsonDecode(emails);
  //     return map;
  //   }
  //   return null;
  // }

  // Future<void> deleteEmailsOtp() async {
  //   await sf.remove('EmailsOtp');
  // }

  Future<void> clean() async {
    sf.clear();
  }
}
