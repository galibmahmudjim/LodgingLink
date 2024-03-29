import 'dart:convert';

import 'package:lodginglink/Profile/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../restApi/rest.dart';

class sharedPref {
  static Future<void> setString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_token', value);
  }

  static Future<String?> getString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('login_token');
  }

  static Future<String?> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("login_token");
    return "200";
  }

  static Future<User?> tokenUser() async {
    var token = await getString();
    if (token == null) return null;
    var response = await Rest.tokenProfile(token);
    User? user;
    if (response!.statusCode == 200) {
      var profile = await jsonDecode(response.body);
      user = User(profile['authdata']['User']['UserID']);
      await user.initialize();
    } else {
      return null;
    }
    return user;
  }
}
