import 'Employee.dart';

class Receptionist extends Employee{
  String? userID;
  String? currentAddress;
  String? organizationalEmail;
  String? organizationalPhone;

  Receptionist(
      {this.userID,
      this.currentAddress,
      this.organizationalEmail,
      this.organizationalPhone});

  Receptionist.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    currentAddress = json['CurrentAddress'];
    organizationalEmail = json['OrganizationalEmail'];
    organizationalPhone = json['OrganizationalPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['CurrentAddress'] = this.currentAddress;
    data['OrganizationalEmail'] = this.organizationalEmail;
    data['OrganizationalPhone'] = this.organizationalPhone;
    return data;
  }
}