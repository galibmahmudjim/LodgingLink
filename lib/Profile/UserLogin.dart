class UserLogin {
  String? userID;
  String? password;
  String? role;
  String? status;

  UserLogin({this.userID, this.password, this.role, this.status});

  UserLogin.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    password = json['Password'];
    role = json['Role'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['Password'] = password;
    data['Role'] = role;
    data['Status'] = status;
    return data;
  }
}
