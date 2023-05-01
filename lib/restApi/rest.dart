import 'dart:convert';
import 'package:http/http.dart' as http;

class Rest {
  static Future<http.Response>? getUsers(String? UserID) async {
    final url = Uri.parse('http://192.168.0.102:6969/getuser');
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    final body = json.encode({'UserID': UserID});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future<http.Response> loginAPI(String UserID, String Password) async {
    final url = Uri.parse('http://192.168.0.102:6969/login');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };
    final body = json.encode({'UserID': UserID, 'Password': Password});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future<http.Response>? tokenProfile(String? token) async {
    final url = Uri.parse('http://192.168.0.102:6969/login/verifyAuth');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    var body = jsonEncode({"token": token});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }
}
