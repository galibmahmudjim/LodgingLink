import 'dart:convert';

import '../restApi/rest.dart';

class User {
  String? _UserID;
  String? _Role;
  String? _Password;
  String? _Status;
  User(String? value) {
    UserID = value;
    getData(value);
  }
  Future<void> initialize() async {
    await getData(UserID);
  }

  //!get all data
  Future<void> getData(String? value) async {
    var response = await Rest.getUsers(value);
    if (response!.statusCode == 200) {
      UserID = jsonDecode(response.body)['UserID'];
      Status = jsonDecode(response.body)['Status'];
      Role = jsonDecode(response.body)['Role'];
      Password = jsonDecode(response.body)['Password'];
    }
  }

  //!get set UserID
  String? get UserID => _UserID;

  set UserID(String? value) {
    _UserID = value;
  }

  //!get set role
  String? get Role => _Role;

  set Role(String? value) {
    _Role = value;
  }

  //!get set loggedin token
  String? get Password => _Password;

  set Password(String? value) {
    _Password = value;
  }

  //!get set status
  String? get Status => _Status;

  set Status(String? value) {
    _Status = value;
  }
}
