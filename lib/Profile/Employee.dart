class Employee {
  String? employeeID;
  String? name;
  String? phoneNumber;
  String? address;
  String? email;
  String? nid;
  String? dateOfBirth;
  String? position;
  String? salary;
  String? joiningDate;
  String? currentStatus;

  Employee(
      {this.employeeID,
      this.name,
      this.phoneNumber,
      this.address,
      this.email,
      this.nid,
      this.dateOfBirth,
      this.position,
      this.salary,
      this.joiningDate,
      this.currentStatus});

  Employee.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    name = json['Name'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    email = json['Email'];
    nid = json['nid'];
    dateOfBirth = json['DateOfBirth'];
    position = json['Position'];
    salary = json['Salary'];
    joiningDate = json['JoiningDate'];
    currentStatus = json['CurrentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeID'] = this.employeeID;
    data['Name'] = this.name;
    data['PhoneNumber'] = this.phoneNumber;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['nid'] = this.nid;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Position'] = this.position;
    data['Salary'] = this.salary;
    data['JoiningDate'] = this.joiningDate;
    data['CurrentStatus'] = this.currentStatus;
    return data;
  }
}