class Room {
  String? _roomID;
  String? _roomNumber;
  String? _roomType;
  String? _roomClass;
  int? _roomOccupancey;
  int? _roomRate;
  bool? _roomAvailablity;

  Room(
      {String? roomID,
      String? roomNumber,
      String? roomType,
      String? roomClass,
      int? roomOccupancey,
      int? roomRate,
      bool? roomAvailablity}) {
    if (roomID != null) {
      this._roomID = roomID;
    }
    if (roomNumber != null) {
      this._roomNumber = roomNumber;
    }
    if (roomType != null) {
      this._roomType = roomType;
    }
    if (roomClass != null) {
      this._roomClass = roomClass;
    }
    if (roomOccupancey != null) {
      this._roomOccupancey = roomOccupancey;
    }
    if (roomRate != null) {
      this._roomRate = roomRate;
    }
    if (roomAvailablity != null) {
      this._roomAvailablity = roomAvailablity;
    }
  }

  String? get roomID => _roomID;
  set roomID(String? roomID) => _roomID = roomID;
  String? get roomNumber => _roomNumber;
  set roomNumber(String? roomNumber) => _roomNumber = roomNumber;
  String? get roomType => _roomType;
  set roomType(String? roomType) => _roomType = roomType;
  String? get roomClass => _roomClass;
  set roomClass(String? roomClass) => _roomClass = roomClass;
  int? get roomOccupancey => _roomOccupancey;
  set roomOccupancey(int? roomOccupancey) => _roomOccupancey = roomOccupancey;
  int? get roomRate => _roomRate;
  set roomRate(int? roomRate) => _roomRate = roomRate;
  bool? get roomAvailablity => _roomAvailablity;
  set roomAvailablity(bool? roomAvailablity) =>
      _roomAvailablity = roomAvailablity;

  Room.fromJson(Map<String, dynamic> json) {
    _roomID = json['RoomID'];
    _roomNumber = json['RoomNumber'];
    _roomType = json['RoomType'];
    _roomClass = json['RoomClass'];
    _roomOccupancey = json['RoomOccupancey'];
    _roomRate = json['RoomRate'];
    _roomAvailablity = json['RoomAvailablity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RoomID'] = this._roomID;
    data['RoomNumber'] = this._roomNumber;
    data['RoomType'] = this._roomType;
    data['RoomClass'] = this._roomClass;
    data['RoomOccupancey'] = this._roomOccupancey;
    data['RoomRate'] = this._roomRate;
    data['RoomAvailablity'] = this._roomAvailablity;
    return data;
  }
}