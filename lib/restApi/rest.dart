import 'dart:convert';

import 'package:http/http.dart' as http;

class Rest {
  void loginAPI(String UserID, String Password) async {
    final url = Uri.parse('http://127.0.0.1:6969/login/loginauth');
    final headers = {'Content-Type': 'application/json', 
                      'Access-Control-Allow-Origin': '*'};
    final body = json.encode({'UserID': UserID, 'Password': Password});
    final response = await http.post(url, headers: headers, body: body);

    print(response.body);
  }
}
