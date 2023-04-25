import '../restApi/rest.dart';

class User {
  String? _UserID;
  String? _Role;
  String? _LoginToken;
  User(String? value) {
    Rest rest = Rest();
    
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
  String? get LoginToken => _LoginToken;

  set LoginToken(String? value) {
    _LoginToken = value;
  }
}
