import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static const String _isLoggedInKey = 'isLoggedIn';

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> logout() async {
    await setLoggedIn(false);
  }
}
