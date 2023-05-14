import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Receptionist/reservation_details_page.dart';
import 'package:lodginglink/Receptionist/topBar.dart';

import '../Profile/Customer.dart';
import '../obj/Reservation.dart';
import '../restApi/rest.dart';
import '../widget/loading.dart';

class CustomerList extends StatefulWidget {
  final User user;
  const CustomerList({Key? key, required this.user}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isLoading = false;
  late List<DataRow> rows = [];
  late List<DataRow> showrow = [];
  List<Customer> customer = [];

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
    CustomerList();
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
          screenName: "Reservation",
          updateload: updateLoad,
          context: context),
      body: Container(
        alignment: Alignment.topCenter,
        child: isLoading
            ? const loading()
            : Container(
                height: screenSize.height / 1.5,
                width: screenSize.width / 1.3,
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 3,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(child: tableRoomList())),
                ),
              ),
      ),
    );
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
                          'Customer ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Phone Nnmber',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 150,
                        child: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'NID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                ],
                rows: rows)));
  }

  final List _isHovering = [false, false, false];
  final List _istapped = [false, false, false];
  final List _color = [
    const Color.fromARGB(133, 10, 10, 10),
    const Color.fromARGB(133, 10, 10, 10),
    const Color.fromARGB(133, 10, 10, 10)
  ];
  List<Widget> rowElements = [];

  late List<Reservation> reservations = [];

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  Future<void> CustomerList() async {
    var row = [];
    List<Customer> datarow = [];
    for (var item in customer) {
      datarow.add(item);
    }
    setState(() {
      rows = datarow
          .map<DataRow>((item) => DataRow(
                cells: [
                  DataCell(Text(item.customerID.toString()), onTap: () {
                  }),
                  DataCell(Text(item.name.toString()), onTap: () {
                    print(item.name);
                  }),
                  DataCell(Text(item.phoneNumber.toString()), onTap: () {
                    print(item.phoneNumber);
                  }),
                  DataCell(Text(item.email.toString()), onTap: () {
                    print(item.email);
                  }),
                  DataCell(Text(item.address.toString()), onTap: () {
                    print(item.address);
                  }),
                  DataCell(Text(item.NID.toString()), onTap: () {
                    print(item.NID);
                  }),
                ],
              ))
          .toList();
      for (var item in rows) {
        setState(() {
          showrow.add(item);
        });
      }
    });
  }

  retrievedata() async {
    Response? data = await Rest.getCustomer();
    List da = jsonDecode(data!.body);
    for (var item in da) {
      customer.add(Customer.fromJson(item));
    }
    CustomerList();
  }
}
