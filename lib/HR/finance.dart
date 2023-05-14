import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lodginglink/HR/topBar.dart';
import 'package:lodginglink/obj/Reservation.dart';

import '../Profile/Employee.dart';
import '../Profile/User.dart';
import '../obj/Inventory.dart';
import '../restApi/rest.dart';

class finace extends StatefulWidget {
  final User user;
  const finace({Key? key, required this.user}) : super(key: key);

  @override
  State<finace> createState() => _finaceState();
}

class _finaceState extends State<finace> {
  bool isLoading = false;

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

  @override
  void initState() {
    super.initState();
    dataset();
  }

  List<TextEditingController> listController1 = [TextEditingController()];
  var screenSize;
  FocusNode field1 = FocusNode();
  FocusNode field2 = FocusNode();
  FocusNode field3 = FocusNode();
  FocusNode field4 = FocusNode();
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: topBar(
        user: widget.user,
        screenName: "Finance",
        updateload: updateLoad,
        context: context,
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: screenSize.width / 10, right: screenSize.width / 10),
        child:
            Card(child: SingleChildScrollView(child: Center(child: AddIn()))),
      ),
    );
  }

  AddIn() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Form(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    title(),
                    Name(),
                    Details(),
                    Cost(),
                    Button(),
                    const SizedBox(
                      height: 50,
                    )
                  ]),
            ),
          ),
        ));
  }

  Name() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 4,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Inventory: ",
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
                width: screenSize.width / 4,
                height: 50,
                child: TextFormField(
                  focusNode: field1,
                  onFieldSubmitted: (value) {
                    field2.requestFocus();
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: controller1,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: "Inventory",
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 54, 49, 54)),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(0, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Details() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 4,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Payments: ",
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
                width: screenSize.width / 4,
                height: 50,
                child: TextFormField(
                  focusNode: field2,
                  onFieldSubmitted: (value) {
                    field3.requestFocus();
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: controller2,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: "Payment",
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 54, 49, 54)),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(0, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Cost() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 4,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Salary: ",
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
                width: screenSize.width / 4,
                height: 50,
                child: TextFormField(
                  focusNode: field3,
                  onFieldSubmitted: (value) {
                    field3.requestFocus();
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: controller3,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: "Salary",
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 54, 49, 54)),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(0, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Button() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 4,
                child: Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "Profit: ",
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
                width: screenSize.width / 4,
                height: 50,
                child: TextFormField(
                  focusNode: field3,
                  onFieldSubmitted: (value) {
                    field3.requestFocus();
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: controller4,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: "Profit",
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 54, 49, 54)),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(0, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  title() {
    return const SizedBox(
      height: 50,
      child: Text(
        "Report",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> dataset() async {
    List<Inventory> inventory = [Inventory()];
    List<Employee> customer = [Employee()];
    List<Reservation> reservation = [Reservation()];
    Response? response1 = await Rest.getemployee();
    Response? response2 = await Rest.getreservation();
    Response? response3 = await Rest.getInventory();

    var da = jsonDecode(response1!.body);
    int salary = 0;
    for (var item in da) {
      Employee temp = Employee.fromJson(item);

      salary = salary + int.parse(temp.salary.toString());
    }
    var da2 = jsonDecode(response3!.body);
    int inventorymoney = 0;
    for (var item in da2) {
      Inventory temp = Inventory.fromJson(item);

      inventorymoney = inventorymoney + int.parse(temp.cost.toString());
    }
    var da3 = jsonDecode(response2!.body);
    int payment = 0;
    for (var item in da3) {
      payment = payment + int.parse(item["Payment"].toString());
    }

    setState(() {
      controller1.text = inventorymoney.toString();
      controller2.text = payment.toString();
      controller3.text = salary.toString();
      controller4.text = (payment -
          salary -
          inventorymoney).toString();
    });
  }
}
