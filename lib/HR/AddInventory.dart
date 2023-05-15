import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lodginglink/HR/inventorylist.dart';
import 'package:lodginglink/HR/topBar.dart';
import 'package:lodginglink/obj/Inventory.dart';

import '../Profile/User.dart';
import '../restApi/rest.dart';

class AddInventory extends StatefulWidget {
  final User user;
  const AddInventory({Key? key, required this.user}) : super(key: key);

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  bool isLoading = false;

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
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
        screenName: "Inventory",
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
                    const SizedBox(
                      height: 50,
                    ),
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
                    "Name: ",
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
                    hintText: "Name",
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
                    "Details: ",
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
                    hintText: "Details",
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
                    "Cost: ",
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
                    hintText: "Cost",
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
      ),
      onPressed: () {
        if (controller1.text.toString().isEmpty ||
            controller2.text.isEmpty ||
            controller3.text.toString().isEmpty) {
          Fluttertoast.showToast(
            msg: "Enter every details",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else {
          addInventory();
        }
      },
      child: const Text('Add Inventory'),
    );
  }

  Future<void> addInventory() async {
    Inventory inventory = Inventory(
        name: controller1.text.toString(),
        details: controller2.text.toString(),
        cost: controller3.text.toString(),
        timestamps: DateTime.now().toString());
    Response? response = await Rest.AddInventory(inventory.toJson());
    if (response!.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Inventory added",
        gravity: ToastGravity.TOP,
        fontSize: 40,
        webPosition: "center",
        webBgColor: "linear-gradient(to right, #ABB900, #ABB900)",
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => inventorylist(user: widget.user)));
    }
  }

  title() {
    return const SizedBox(
      height: 50,
      child: Text(
        "Add Inventory",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }
}
