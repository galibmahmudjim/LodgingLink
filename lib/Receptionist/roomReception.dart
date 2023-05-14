import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lodginglink/Receptionist/receptionistMakeReserve.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:lodginglink/obj/Reservation.dart';
import 'package:lodginglink/widget/loading.dart';
import 'package:intl/intl.dart';

import '../Profile/User.dart';
import '../obj/Room.dart';
import '../restApi/rest.dart';

class RoomReception extends StatefulWidget {
  final User user;
  const RoomReception({Key? key, required this.user}) : super(key: key);

  @override
  State<RoomReception> createState() => _RoomReceptionState();
}

class _RoomReceptionState extends State<RoomReception> {
  bool isLoading = false;
  late List<DataRow> rows = [];
  late List<DataRow> showrow = [];

  List<Room> datarow = [];
  DateTime startcheckindate = DateTime.now();

  DateTime startcheckoutdate = DateTime.now();

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievedata();
  }

  var screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: topBar(
            user: widget.user,
            screenName: "Room",
            updateload: updateLoad,
            context: context),
        body: Column(
          children: [
            roomReceptionistAppbarcarrdConten(),
            daterange(),
            isLoading
                ? const loading()
                : Container(
                    height: screenSize.height / 1.5,
                    width: screenSize.width / 1.3,
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 3,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                          child: SingleChildScrollView(child: tableRoomList())),
                    ),
                  ),
          ],
        ));
  }

  int currentSortColumn = 0;
  bool isAscending = false;
  void _sort(int columnIndex, bool ascending) {
    setState(() {
      currentSortColumn = columnIndex;
      isAscending = ascending;
    });
    rows.sort((row1, row2) {
      final value1 = row1.cells.elementAt(currentSortColumn).child.toString();
      final value2 = row2.cells.elementAt(currentSortColumn).child.toString();
      if (isAscending) {
        if (value1.length != value2.length) {
          if (value1.length > value2.length) {
            return 1;
          } else if (value1.length <= value2.length) {
            return -1;
          }
        } else {
          return value1.compareTo(value2);
        }
      } else {
        if (value1.length != value2.length) {
          if (value1.length <= value2.length) {
            return 1;
          } else if (value1.length >= value2.length) {
            return -1;
          }
        } else {
          return value2.compareTo(value1);
        }
      }
      return 1;
    });
  }

  tableRoomList() {
    return Center(
        heightFactor: 1,
        child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 2,
            ),
            child: DataTable(
                sortAscending: isAscending,
                sortColumnIndex: currentSortColumn,
                columns: <DataColumn>[
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Room No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Room Type',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Class',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 150,
                        child: Text(
                          'Maximum Occupancey',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Room rate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                ],
                rows: rows)));
  }

  final List _isHovering = [false, false, false];
  List _istapped = [false, false, false];
  List _color = [
    const Color.fromARGB(133, 10, 10, 10),
    const Color.fromARGB(133, 10, 10, 10),
    const Color.fromARGB(133, 10, 10, 10)
  ];
  List<Widget> rowElements = [];

  late List<Reservation> reservations = [];

  List<String> items = ['Room List', 'Available Room', 'Reserved Room'];
  List<IconData> icons = [
    Icons.location_on,
    Icons.date_range,
    Icons.people,
    Icons.wb_sunny
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            (value == true && _istapped[i] != true)
                ? _isHovering[i] = true
                : _isHovering[i] = false;
          });
          if (value == true && _istapped[i] == false) {
            setState(() {
              _color[i] = const Color.fromARGB(255, 0, 0, 0);
            });
          } else if (_istapped[i] == false) {
            setState(() {
              _color[i] = const Color.fromARGB(133, 10, 10, 10);
            });
          }
        },
        onTap: () {
          setState(() {
            _istapped = List.filled(_istapped.length, false);
            _color = List.filled(
                _color.length, const Color.fromARGB(133, 10, 10, 10));
          });
          if (i == 0) {
            setState(() {
              _color[i] = Colors.white;
              _istapped[i] = true;
            });

            rowRoomList();
          } else if (i == 1) {
            setState(() {
              _color[i] = Colors.white;
              _istapped[i] = true;
            });
            availableroom();
          } else if (i == 2) {
            setState(() {
              _color[i] = Colors.white;
              _istapped[i] = true;
              reserved();
            });
          }
        },
        child: Text(
          items[i],
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
              color: _color[i]),
        ),
      );
      Widget spacer = SizedBox(
        height: screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }
    return rowElements;
  }

  roomReceptionistAppbarcarrdConten() {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: 5,
          left: screenSize.width / 5,
          right: screenSize.width / 5,
        ),
        child: Card(
            elevation: 4,
            color: const Color.fromARGB(163, 255, 255, 255),
            child: Center(
              heightFactor: 1,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: generateRowElements(),
                  )),
            )),
      ),
    );
  }

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  Future<void> rowRoomList() async {
    var row = [];
    var response = await Rest.getRoomList();
    var data = jsonDecode(response!.body);
    for (var item in data) {
      var temp = Room.fromJson(item);
      if (temp.roomNumber != null) {
        datarow.add(temp);
      }
    }

    setState(() {
      datarow.removeWhere((value) => value.roomNumber == null);
    });
    setState(() {
      rows = datarow
          .map<DataRow>((item) => DataRow(
                cells: [
                  DataCell(Text(item.roomNumber.toString()), onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => receptionistMakeReservation(
                                user: widget.user, room: item)));
                  }),
                  DataCell(Text(item.roomType.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomClass.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomOccupancey.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomRate.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomAvailablity.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                ],
              ))
          .toList();
    });
  }

  retrievedata() async {
    Response? data = await Rest.getreservation();
    List da = jsonDecode(data!.body);
    for (var element in da) {
      Reservation temp = Reservation(
          reservationID: element["ReservationID"],
          reservationDate: element["ReservationDate"],
          durationOfStay: int.parse(element["DurationOfStay"].toString()),
          checkInDate: element["CheckInDate"],
          checkOutDate: element["CheckOutDate"],
          customerID: element["CustomerID"],
          totalRoom: element["TotalRoom"],
          roomNumber: element["RoomNumber"],
          duePayment: int.parse(element["DuePayment"].toString()),
          totalAmmount: int.parse(element["TotalAmmount"].toString()),
          paymentMethod: element["PaymentMethod"],
          Payment: element["Payment"],
          reservationStatus: element["ReservationStatus"]);
      reservations.add(temp);
    }
  }

  Future<void> availableroom() async {
    List<String> roomList = [];
    DateTime checkInDatetime;
    List<Room> rooms = [Room()];

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      rows.clear();
      showrow.clear();
    });
    for (var item in reservations) {
      DateTime d1 = dateFormat.parse(item.checkInDate.toString());
      DateTime d2 = dateFormat.parse(item.checkOutDate.toString());
      String str1 = DateFormat("dd-MM-yyyy").format(startcheckindate);
      String str2 = DateFormat("dd-MM-yyyy").format(startcheckoutdate);
      DateTime s1 = dateFormat.parse(str1.toString());
      DateTime s2 = dateFormat.parse(str2.toString());
      if (!(d1.isAfter(s2) || d2.isBefore(s1))) {
        roomList.add(item.roomNumber.toString());
      }
    }
    setState(() {
      datarow.removeWhere((value) => value.roomNumber == null);
    });
    for (var item in datarow) {
      if (!roomList.contains(item.roomNumber.toString()) &&
          item.roomNumber != null) {
        rooms.add(item);
      }
    }

    setState(() {
      rooms.removeWhere((value) => value.roomNumber == null);
    });
    setState(() {
      rows = rooms
          .map<DataRow>((item) => DataRow(
                cells: [
                  DataCell(Text(item.roomNumber.toString()), onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => receptionistMakeReservation(
                                user: widget.user, room: item)));
                  }),
                  DataCell(Text(item.roomType.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomClass.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomOccupancey.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomRate.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomAvailablity.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                ],
              ))
          .toList();
    });
  }

  daterange() {
    return Card(
      margin: EdgeInsets.only(
          left: screenSize.width / 9, right: screenSize.width / 9),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: screenSize.width / 6,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Check-In date: ",
                    style: TextStyle(
                      fontFamily: "Railway",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: screenSize.width / 8,
                  height: 50,
                  child: DateTimeField(
                      firstDate: DateTime.now(),
                      mode: DateTimeFieldPickerMode.date,
                      dateTextStyle: const TextStyle(
                        fontFamily: "Railway",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: const InputDecoration(
                          hintText: 'Pick Check-in date',
                          prefixIcon: Icon(Icons.calendar_month),
                          prefixIconColor: Color.fromARGB(137, 0, 0, 0)),
                      selectedDate: startcheckindate,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          startcheckindate = value;
                        });
                      })),
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                width: screenSize.width / 6,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Check-Out date: ",
                    style: TextStyle(
                      fontFamily: "Railway",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: screenSize.width / 8,
                  height: 50,
                  child: DateTimeField(
                      firstDate: DateTime.now(),
                      mode: DateTimeFieldPickerMode.date,
                      dateTextStyle: const TextStyle(
                        fontFamily: "Railway",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: const InputDecoration(
                          hintText: 'Pick Check-out date',
                          prefixIcon: Icon(Icons.calendar_month),
                          prefixIconColor: Color.fromARGB(137, 0, 0, 0)),
                      selectedDate: startcheckoutdate,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          startcheckoutdate = value;
                        });
                      }))
            ]),
          ],
        ),
      ),
    );
  }

  void reserved() {
    List<String> roomList = [];
    DateTime checkInDatetime;
    List<Room> rooms = [Room()];

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      rows.clear();
      showrow.clear();
    });
    for (var item in reservations) {
      DateTime d1 = dateFormat.parse(item.checkInDate.toString());
      DateTime d2 = dateFormat.parse(item.checkOutDate.toString());
      String str1 = DateFormat("dd-MM-yyyy").format(startcheckindate);
      String str2 = DateFormat("dd-MM-yyyy").format(startcheckoutdate);
      DateTime s1 = dateFormat.parse(str1.toString());
      DateTime s2 = dateFormat.parse(str2.toString());
      if (!(d1.isAfter(s2) || d2.isBefore(s1))) {
        roomList.add(item.roomNumber.toString());
      }
    }
    setState(() {
      datarow.removeWhere((value) => value.roomNumber == null);
    });
    for (var item in datarow) {
      if (roomList.contains(item.roomNumber.toString()) &&
          item.roomNumber != null) {
        rooms.add(item);
      }
    }

    setState(() {
      rooms.removeWhere((value) => value.roomNumber == null);
    });
    setState(() {
      rows = rooms
          .map<DataRow>((item) => DataRow(
                cells: [
                  DataCell(Text(item.roomNumber.toString()), onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => receptionistMakeReservation(
                                user: widget.user, room: item)));
                  }),
                  DataCell(Text(item.roomType.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomClass.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomOccupancey.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomRate.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                  DataCell(Text(item.roomAvailablity.toString()), onTap: () {
                    print(item.roomNumber);
                  }),
                ],
              ))
          .toList();
    });
  }
}
