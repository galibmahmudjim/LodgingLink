class Customer {
  String? _customerID;
  String? _name;
  String? _phoneNumber;
  String? _email;
  String? _address;
  String? _NID;
  String? _dateOfBirth;

  Customer(
      {String? customerID,
      String? name,
      String? phoneNumber,
      String? email,
      String? address,
      String? NID,
      String? dateOfBirth}) {
    if (customerID != null) {
      _customerID = customerID;
    }
    if (name != null) {
      _name = name;
    }
    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }
    if (email != null) {
      _email = email;
    }
    if (address != null) {
      _address = address;
    }
    if (NID != null) {
      _NID = NID;
    }
    if (dateOfBirth != null) {
      _dateOfBirth = dateOfBirth;
    }
  }

  String? get customerID => _customerID;
  set customerID(String? customerID) => _customerID = customerID;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get NID => _NID;
  set NID(String? NID) => _NID = NID;
  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? dateOfBirth) => _dateOfBirth = dateOfBirth;

  Customer.fromJson(Map<String, dynamic> json) {
    _customerID = json['CustomerID'];
    _name = json['Name'];
    _phoneNumber = json['PhoneNumber'];
    _email = json['Email'];
    _address = json['Address'];
    _NID = json['NID'];
    _dateOfBirth = json['DateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerID'] = _customerID;
    data['Name'] = _name;
    data['PhoneNumber'] = _phoneNumber;
    data['Email'] = _email;
    data['Address'] = _address;
    data['NID'] = _NID;
    data['DateOfBirth'] = _dateOfBirth;
    return data;
  }
}
