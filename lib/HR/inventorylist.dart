import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lodginglink/HR/topBar.dart';
import 'package:lodginglink/obj/Inventory.dart';

import '../Profile/User.dart';
import '../restApi/rest.dart';
import '../widget/loading.dart';
import 'AddInventory.dart';

class inventorylist extends StatefulWidget {
  final User user;
  const inventorylist({Key? key, required this.user}) : super(key: key);

  @override
  State<inventorylist> createState() => _inventorylistState();
}

class _inventorylistState extends State<inventorylist> {
  bool isLoading = false;
  late List<DataRow> rows = [];
  late List<DataRow> showrow = [];
  List<Inventory> inventorylist = [];

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
    inventorydata();
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
          screenName: "Inventory",
          updateload: updateLoad,
          context: context),
      body: Container(
        alignment: Alignment.topCenter,
        child: isLoading
            ? const loading()
            : Container(
                height: screenSize.height / 1.1,
                width: screenSize.width / 1.3,
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                              child: tableInventoryList())),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontStyle: FontStyle.normal),
                          ),
                          onPressed: () {
                            addInventory();
                          },
                          child: const Text('Add Inventory'),
                        ),
                      )
                    ],
                  ),
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

  tableInventoryList() {
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
                          'Item Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 200,
                        child: Text(
                          'Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 100,
                        child: Text(
                          'Cost',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onSort: (columnIndex, _) => _sort(columnIndex, _)),
                  DataColumn(
                      label: const SizedBox(
                        width: 150,
                        child: Text(
                          'Time and Date',
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

  late List<Inventory> inventories = [];

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  Future<void> inventorydata() async {
    var row = [];
    List<Inventory> datarow = [];
    for (var item in inventorylist) {
      datarow.add(item);
    }
    setState(() {
      rows = datarow
          .map<DataRow>((item) => DataRow(
                cells: [
                  DataCell(Text(item.name.toString()), onTap: () {}),
                  DataCell(Text(item.details.toString()), onTap: () {
                    print(item.details);
                  }),
                  DataCell(Text(item.cost.toString()), onTap: () {
                    print(item.cost);
                  }),
                  DataCell(Text(item.timestamps.toString()), onTap: () {
                    print(item.timestamps);
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
   
    inventorydata();
  }

  addInventory() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (contex) => AddInventory(user: widget.user)));
  }
}
