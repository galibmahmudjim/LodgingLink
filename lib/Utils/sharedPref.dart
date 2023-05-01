import 'package:shared_preferences/shared_preferences.dart';

class sharedPref {
  static Future<void> setString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_token', value);
  }

  static Future<String?> getString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_token');
  }
}
