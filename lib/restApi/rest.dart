import 'dart:convert';
import 'package:http/http.dart' as http;

class Rest {
  static String ip = "192.168.0.103";
  static Future<http.Response>? getUsers(String? UserID) async {
    final url = Uri.parse('http://$ip:6969/getuser');
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    final body = json.encode({'UserID': UserID});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future<http.Response> loginAPI(String UserID, String Password) async {
    final url = Uri.parse('http://$ip:6969/login');
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
    final url = Uri.parse('http://$ip:6969/login/verifyAuth');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    var body = jsonEncode({"token": token});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future<http.Response>? updatePassword(
      String? UserID, String? Password, String? Status) async {
    final url = Uri.parse('http://$ip:6969/updatePassword');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    var body =
        jsonEncode({"UserID": UserID, "Password": Password, "Status": Status});
    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future<http.Response>? getRoomList() async {
    final url = Uri.parse('http://$ip:6969/getroomlist');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response = await http.post(url);
    return response;
  }

  static Future<http.Response>? addCustomer(var customer) async {
    final url = Uri.parse('http://$ip:6969/addcustomer');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(customer));
    return response;
  }

  static Future<http.Response>? addReservation(var reservation) async {
    final url = Uri.parse('http://$ip:6969/addreservation');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(reservation));
    return response;
  }

  static Future<http.Response>? getCustomerNid(var nid) async {
    final url = Uri.parse('http://$ip:6969/getcustomerNid');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(nid));
    return response;
  }

  static Future<http.Response>? getCustomerid(var CustomerID) async {
    final url = Uri.parse('http://$ip:6969/getcustomerid');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(CustomerID));
    return response;
  }

  static Future<http.Response>? getCustomer() async {
    final url = Uri.parse('http://$ip:6969/getcustomer');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response = await http.post(url);
    return response;
  }

  static Future<http.Response>? updatereservation(var reservation) async {
    final url = Uri.parse('http://$ip:6969/updatereservation');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(reservation));
    return response;
  }

  static Future<http.Response>? getCustomerEmail(var Email) async {
    final url = Uri.parse('http://$ip:6969/getcustomerEmail');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(Email));
    return response;
  }

  static Future<http.Response>? getCustomerPhone(var Phone) async {
    final url = Uri.parse('http://$ip:6969/getcustomerPhoneNumber');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(Phone));
    return response;
  }

  static Future<http.Response>? getreservation() async {
    final url = Uri.parse('http://$ip:6969/getreservation');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response = await http.post(url);
    return response;
  }

  static Future<http.Response>? getreservationhistroy() async {
    final url = Uri.parse('http://$ip:6969/getreservationhistory');

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response = await http.post(url);
    return response;
  }

  static Future<http.Response>? getreservationid(var body) async {
    final url = Uri.parse('http://$ip:6969/getreservationid');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }

  static Future<http.Response>? addemployee(var body) async {
    final url = Uri.parse('http://$ip:6969/addemployee');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }

  static Future<http.Response>? getemployee() async {
    final url = Uri.parse('http://$ip:6969/getemployee');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };

    final response = await http.post(url);
    return response;
  }

  static Future<http.Response>? getemployeeID(var body) async {
    final url = Uri.parse('http://$ip:6969/getemployeeID');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };
    print(body);

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }
    static Future<http.Response>? updateemployee(var body) async {
    final url = Uri.parse('http://$ip:6969/updateemployee');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };
    print(body);

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }
     static Future<http.Response>? addusers(var body) async {
    final url = Uri.parse('http://$ip:6969/addusers');
    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      'Accept': '*/*'
    };
    print(body);

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }
  
}
