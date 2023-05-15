import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Receptionist/homePageReception.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:lodginglink/obj/Reservation.dart';

import '../Profile/Customer.dart';
import '../restApi/rest.dart';

class ReservationDetailsPage extends StatefulWidget {
  final User user;
  final String reservationID;
  const ReservationDetailsPage(
      {Key? key, required this.user, required this.reservationID})
      : super(key: key);

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  var isLoading = false;

  var roomnumberpreviewController = TextEditingController();
  var resevationidpreviewController = TextEditingController();

  var checkindatepreviewController = TextEditingController();

  var checkoutdatepreviewController = TextEditingController();

  var durationpreviewController = TextEditingController();

  var reservationdatepreviewController = TextEditingController();

  var totalroompreviewController = TextEditingController();

  var customernamepreviewController = TextEditingController();

  String dropdownvalue = "Reserved";

  var customeridpreviewController = TextEditingController();

  var phonenumberpreviewController = TextEditingController();

  var emailpreviewController = TextEditingController();

  var addresspreviewController = TextEditingController();

  var nidpreviewController = TextEditingController();

  var dobpreviewController = TextEditingController();

  var totalammountpreviewController = TextEditingController();

  var paymentpreviewController = TextEditingController();

  var dueammountpreviewController = TextEditingController();

  var paymentmethodpreviewController = TextEditingController();

  var reservationstatuspreviewController = TextEditingController();

  late Customer customer = Customer();
  late Reservation reservation = Reservation();

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

  @override
  void initState() {
    super.initState();
    retrieve();
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
        margin: EdgeInsets.only(
            left: screenSize.width / 10, right: screenSize.width / 10),
        child:
            Card(child: SingleChildScrollView(child: Center(child: Details()))),
      ),
    );
  }

  Details() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          child: Form(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    roomNumberPreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    ReservationIDpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    checkindatepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    checkoutdatepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    durationstaypreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    reservationdatepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    totalroompreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    customernameamepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    customeridpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    phonepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    emailpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    addresspreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    nidpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    dobpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    totalammountpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    paymentpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    duepreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    paymethodpreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    Rservationstatuspreview(),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: Submit, child: const Text("Submit"))
                  ]),
            ),
          ),
        ));
  }

  roomNumberPreview() {
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
                    "Room Number: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: roomnumberpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  ReservationIDpreview() {
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
                    "Reservation ID: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: resevationidpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  checkindatepreview() {
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
                    "Check-In Date: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: checkindatepreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  checkoutdatepreview() {
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
                    "Check-Out Date: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: checkoutdatepreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  durationstaypreview() {
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
                    "Duration of Stay: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: durationpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  reservationdatepreview() {
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
                    "Reservation Date: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: reservationdatepreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  totalroompreview() {
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
                    "Total Room: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: totalroompreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  customernameamepreview() {
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
                    "Customer Name: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: customernamepreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  customeridpreview() {
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
                    "Customer ID: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: customeridpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  phonepreview() {
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
                    "Phone Number: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: phonenumberpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  emailpreview() {
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
                    "Email: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: emailpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  addresspreview() {
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
                    "Address: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: addresspreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  nidpreview() {
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
                    "NID: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: nidpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  dobpreview() {
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
                    "Date of Birth: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: dobpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  totalammountpreview() {
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
                    "Total Ammount: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: totalammountpreviewController,
                  decoration: InputDecoration(
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

  paymentpreview() {
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
                    "Payment: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: paymentpreviewController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        dueammountpreviewController.text = (int.parse(
                                    totalammountpreviewController.text
                                        .toString()) -
                                int.parse(value.toString()))
                            .toString();
                      });
                    }
                  },
                  decoration: InputDecoration(
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

  duepreview() {
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
                    "Due Payment: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: dueammountpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  paymethodpreview() {
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
                    "Payment Method: ",
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
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: paymentmethodpreviewController,
                  enabled: false,
                  decoration: InputDecoration(
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

  var items = ['Reserved', 'Cancelled', 'Check-Out'];
  Rservationstatuspreview() {
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
                    "Reservation Status: ",
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
                child: DropdownButton(
                  focusColor: Colors.white,
                  value: dropdownvalue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submit() async {
    reservation.totalAmmount =
        int.parse(totalammountpreviewController.text.toString());
    reservation.Payment = int.parse(paymentpreviewController.text.toString());
    reservation.duePayment =
        int.parse(dueammountpreviewController.text.toString());
    reservation.reservationStatus =
        dropdownvalue;
    var json = reservation.toJson();
    print(json);
    Response? respanse = await Rest.updatereservation(reservation);
    if (respanse!.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => homePageReception(user: widget.user)));
    }
  }

  Future<void> retrieve() async {
    Map<String, dynamic> id = {
      "ReservationID": widget.reservationID.toString()
    };
    Response? response = await Rest.getreservationid(id);
    if (response!.statusCode == 200) {
      var da = jsonDecode(response.body);
      reservation = Reservation(
          reservationID: da["ReservationID"],
          reservationDate: da["ReservationDate"],
          durationOfStay: int.parse(da["DurationOfStay"].toString()),
          checkInDate: da["CheckInDate"],
          checkOutDate: da["CheckOutDate"],
          customerID: da["CustomerID"],
          totalRoom: da["TotalRoom"],
          roomNumber: da["RoomNumber"],
          duePayment: int.parse(da["DuePayment"].toString()),
          totalAmmount: int.parse(da["TotalAmmount"].toString()),
          paymentMethod: da["PaymentMethod"],
          Payment: da["Payment"],
          reservationStatus: da["ReservationStatus"]);
    }

    Response? response1 =
        await Rest.getCustomerid({"CustomerID": reservation.customerID});
    if (response1!.statusCode == 200) {
      customer = Customer.fromJson(jsonDecode(response1.body));
    }
    setState(() {
      roomnumberpreviewController.text = reservation.roomNumber.toString();
      resevationidpreviewController.text = reservation.reservationID.toString();

      checkindatepreviewController.text = reservation.checkInDate.toString();

      checkoutdatepreviewController.text = reservation.checkOutDate.toString();

      durationpreviewController.text = reservation.durationOfStay.toString();

      reservationdatepreviewController.text =
          reservation.reservationDate.toString();

      totalroompreviewController.text = reservation.totalRoom.toString();

      customernamepreviewController.text = customer.name.toString();

      customeridpreviewController.text = customer.customerID.toString();

      phonenumberpreviewController.text = customer.phoneNumber.toString();

      emailpreviewController.text = customer.email.toString();

      addresspreviewController.text = customer.address.toString();

      nidpreviewController.text = customer.NID.toString();

      dobpreviewController.text = customer.dateOfBirth.toString();

      totalammountpreviewController.text = reservation.totalAmmount.toString();

      paymentpreviewController.text = reservation.Payment.toString();

      dueammountpreviewController.text = reservation.duePayment.toString();

      paymentmethodpreviewController.text = reservation.paymetMethod.toString();

      dropdownvalue = reservation.reservationStatus.toString().isEmpty
          ? "Reserved"
          : reservation.reservationStatus.toString();
    });
  }

  void Submit() {
    submit();
  }
}
