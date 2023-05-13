class Reservation {
  String? _reservationID;
  String? _reservationDate;
  int? _durationOfStay;
  String? _checkInDate;
  String? _checkOutDate;
  String? _customerID;
  int? _totalRoom;
  String? _roomNumber;
  int? _duePayment;
  int? _totalAmmount;
  int? _Payment;
  String? _reservationStatus;
  String? _paymentMethod;

  Reservation(
      {String? reservationID,
      String? reservationDate,
      int? durationOfStay,
      String? checkInDate,
      String? checkOutDate,
      String? customerID,
      int? totalRoom,
      String? roomNumber,
      int? duePayment,
      int? totalAmmount,
      String? paymentMethod,
      int? Payment,
      String? reservationStatus}) {
    if (reservationID != null) {
      _reservationID = reservationID;
    }
    if (reservationDate != null) {
      _reservationDate = reservationDate;
    }
    if (durationOfStay != null) {
      _durationOfStay = durationOfStay;
    }
    if (checkInDate != null) {
      _checkInDate = checkInDate;
    }
    if (checkOutDate != null) {
      _checkOutDate = checkOutDate;
    }
    if (customerID != null) {
      _customerID = customerID;
    }
    if (totalRoom != null) {
      _totalRoom = totalRoom;
    }
    if (roomNumber != null) {
      _roomNumber = roomNumber;
    }
    if (duePayment != null) {
      _duePayment = duePayment;
    }
    if (totalAmmount != null) {
      _totalAmmount = totalAmmount;
    }
    if (reservationStatus != null) {
      _reservationStatus = reservationStatus;
    }
    if (Payment != null) {
      _Payment = Payment;
    }
    if (paymentMethod != null) {
      _paymentMethod = paymentMethod;
    }
  }

  String? get reservationID => _reservationID;
  set reservationID(String? reservationID) => _reservationID = reservationID;
  String? get reservationDate => _reservationDate;
  set reservationDate(String? reservationDate) =>
      _reservationDate = reservationDate;
  int? get durationOfStay => _durationOfStay;
  set durationOfStay(int? durationOfStay) => _durationOfStay = durationOfStay;
  String? get checkInDate => _checkInDate;
  set checkInDate(String? checkInDate) => _checkInDate = checkInDate;
  String? get checkOutDate => _checkOutDate;
  set checkOutDate(String? checkOutDate) => _checkOutDate = checkOutDate;
  String? get customerID => _customerID;
  set customerID(String? customerID) => _customerID = customerID;
  int? get totalRoom => _totalRoom;
  set totalRoom(int? totalRoom) => _totalRoom = totalRoom;
  String? get roomNumber => _roomNumber;
  set roomNumber(String? roomNumber) => _roomNumber = roomNumber;
  int? get duePayment => _duePayment;
  set duePayment(int? duePayment) => _duePayment = duePayment;
  int? get totalAmmount => _totalAmmount;
  set totalAmmount(int? totalAmmount) => _totalAmmount = totalAmmount;
  String? get reservationStatus => _reservationStatus;
  set reservationStatus(String? reservationStatus) =>
      _reservationStatus = reservationStatus;
  int? get Payment => _Payment;
  set Payment(int? Payment) => _Payment = Payment;
  String? get paymetMethod => _paymentMethod;
  set paymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;

  Reservation.fromJson(Map<String, dynamic> json) {
    _reservationID = json['ReservationID'];
    _reservationDate = json['ReservationDate'];
    _durationOfStay = json['DurationOfStay'];
    _checkInDate = json['CheckInDate'];
    _checkOutDate = json['CheckOutDate'];
    _customerID = json['CustomerID'];
    _totalRoom = json['TotalRoom'];
    _roomNumber = json['RoomNumber'].cast<String>();
    _duePayment = json['DuePayment'];
    _totalAmmount = json['TotalAmmount'];
    _reservationStatus = json['ReservationStatus'];
    _Payment = json['Payment'];
    _paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReservationID'] = _reservationID;
    data['ReservationDate'] = _reservationDate;
    data['DurationOfStay'] = _durationOfStay;
    data['CheckInDate'] = _checkInDate;
    data['CheckOutDate'] = _checkOutDate;
    data['CustomerID'] = _customerID;
    data['TotalRoom'] = _totalRoom;
    data['RoomNumber'] = _roomNumber;
    data['DuePayment'] = _duePayment;
    data['TotalAmmount'] = _totalAmmount;
    data['ReservationStatus'] = _reservationStatus;
    data['paymentMethod'] = _paymentMethod;
    data['Payment'] = _Payment;
    return data;
  }
}
