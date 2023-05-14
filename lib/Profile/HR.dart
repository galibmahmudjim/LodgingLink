import 'package:lodginglink/Profile/Employee.dart';

class HR  extends Employee{
  String? userID;
  String? currentAddress;
  String? organizationalEmail;

  HR({this.userID, this.currentAddress, this.organizationalEmail});

  HR.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    currentAddress = json['CurrentAddress'];
    organizationalEmail = json['OrganizationalEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['CurrentAddress'] = this.currentAddress;
    data['OrganizationalEmail'] = this.organizationalEmail;
    return data;
  }
}