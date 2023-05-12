import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Profile/User.dart';
import '../obj/Room.dart';

class receptionistMakeReservation extends StatefulWidget {
  final User user;
  final Room room;

  const receptionistMakeReservation({
    Key? key,
    required this.user,
    required this.room,
  }) : super(key: key);

  @override
  State<receptionistMakeReservation> createState() =>
      _receptionistMakeReservationState();
}

class _receptionistMakeReservationState
    extends State<receptionistMakeReservation> {
//! Initialize var
  bool isLoading = false;
  final String _selectedDate = '';
  DateTime checkindate = DateTime.now();
  final String _dateCount = '';
  final String _range = '';
  final String _rangeCount = '';
  DateTime checkoutdate = DateTime.now();
  final String _CheckoutDate = '';
  var _currentStep = 0;
  var roomnumberController;

  final _formKey = GlobalKey<FormState>();
  var screenSize;
  var roomNumberKey;
  var roomnameController = TextEditingController();
  var checkindatecontroller = TextEditingController();
  var durationofstaycontroller = TextEditingController(text: "1");
  var checkoutdatecontroller = TextEditingController();
  var customernameController = TextEditingController();
  var customerphoneNumberController = TextEditingController();
  final RoundedLoadingButtonController roundloadPhoneController =
      RoundedLoadingButtonController();
  var customeremailController = TextEditingController();

  var roundloademailController = RoundedLoadingButtonController();

  var customeraddressController = TextEditingController();

  var customernidController = TextEditingController();

  var roundloadnidController = RoundedLoadingButtonController();

//!var

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomnameController.text = widget.room.roomNumber.toString();
  }

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
        child: Center(child: reservationForm()),
      ),
    );
  }

//!reservation form
  reservationForm() {
    return Column(
      children: [reservationStepts()],
    );
  }

//!updateload
  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

//!form title
  formTitle() {
    return const Text(
      "Enter Reservation Details",
      style: TextStyle(
        fontSize: 26,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w900,
      ),
    );
  }

//! reservation steps

  reservationStepts() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          formTitle(),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stepper(
                type: StepperType.vertical,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepContinue: continueStep,
                onStepCancel: cancelledStep,
                elevation: 5,
                onStepTapped: tabbedStep,
                controlsBuilder: customControllbuilder,
                steps: [
                  Step(
                      title: ReservationDetailsStepTittle(),
                      content: reservationDetailsForm(),
                      isActive: (_currentStep >= 0),
                      state: (_currentStep > 0 &&
                              int.parse(
                                      durationofstaycontroller.text.toString()) >
                                  0)
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                      title: const Text(
                        "Customer Details",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      content: customerDetailsForm(),
                      isActive: (_currentStep >= 1),
                      state: (_currentStep > 1)
                          ? StepState.complete
                          : StepState.disabled),
                  Step(
                      title: const Text(
                        "Payment",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      content: const Text("This is Payment details"),
                      isActive: (_currentStep >= 2),
                      state: (_currentStep > 2)
                          ? StepState.complete
                          : StepState.disabled),
                ]),
          ),
        ]),
      ),
    );
  }

//!reservation step title
  ReservationDetailsStepTittle() {
    return const Text(
      "Reservation Details",
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Raleway',
      ),
    );
  }

//!_current step
  void continueStep() {
    setState(() {
      setState(() {
        if (_currentStep == 1 &&
            int.parse(durationofstaycontroller.text.toString()) < 1) {
          Fluttertoast.showToast(
            msg: "Please enter check-in check-out date correctly",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (_currentStep < 2) {
          _currentStep++;
        }
      });
    });
  }

  void cancelledStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void tabbedStep(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  Widget customControllbuilder(BuildContext context, ControlsDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: details.onStepContinue,
            child: (_currentStep == 2)
                ? const Text("Review")
                : const Text("Next")),
        const SizedBox(
          width: 20,
        ),
        OutlinedButton(
            onPressed: details.onStepCancel, child: const Text("Back"))
      ],
    );
  }

//!reservation details step
  reservationDetailsForm() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    roomNumber(),
                    const SizedBox(
                      height: 10,
                    ),
                    times(),
                  ]),
            ),
          ),
        ));
  }

  roomNumber() {
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
                  controller: roomnameController,
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

  times() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 4,
                    child: Container(
                      color: Colors.white,
                      alignment: AlignmentDirectional.centerStart,
                      child: const Text(
                        "Check in date: ",
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
                    child: checkinDateField(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 4,
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
                    width: screenSize.width / 4,
                    height: 50,
                    child: checkoutDateField(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 4,
                    child: Container(
                      color: Colors.white,
                      alignment: AlignmentDirectional.centerStart,
                      child: const Text(
                        "Duration of stay: ",
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
                      controller: durationofstaycontroller,
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
            ],
          ),
        ),
      ),
    );
  }

  checkinDateField() {
    return DateTimeField(
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
        selectedDate: checkindate,
        onDateSelected: (DateTime value) {
          setState(() {
            checkindate = value;
          });
          if (checkoutdate.difference(checkindate).inDays < 1) {
            setState(() {
              checkoutdate = checkindate;
              durationofstaycontroller.text =
                  (checkoutdate.difference(checkindate).inDays + 1).toString();
            });
          }
        });
  }

  checkoutDateField() {
    return DateTimeField(
        firstDate: DateTime.now(),
        mode: DateTimeFieldPickerMode.date,
        dateTextStyle: const TextStyle(
          fontFamily: "Railway",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        decoration: const InputDecoration(
            hintText: 'Pick Check-Out date',
            prefixIcon: Icon(Icons.calendar_month),
            prefixIconColor: Color.fromARGB(137, 0, 0, 0)),
        selectedDate: checkoutdate,
        onDateSelected: (DateTime value) {
          if (checkoutdate.difference(checkindate).inDays < 1) {
            setState(() {
              checkoutdate = checkindate;
            });
            Fluttertoast.showToast(
              msg: "Invalid check-out Date",
              gravity: ToastGravity.TOP,
              fontSize: 40,
              webPosition: "center",
              webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
            );
          } else {
            setState(() {
              checkoutdate = value;
            });
          }
          setState(() {
            durationofstaycontroller.text =
                (checkoutdate.difference(checkindate).inDays + 1).toString();
          });
        });
  }

//! customer step
  customerDetailsForm() {
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
                    NameCustomer(),
                    const SizedBox(
                      height: 10,
                    ),
                    phoneNumber(),
                    const SizedBox(
                      height: 10,
                    ),
                    email(),
                    const SizedBox(
                      height: 10,
                    ),
                    address(),
                    const SizedBox(
                      height: 10,
                    ),
                    nid(),
                  ]),
            ),
          ),
        ));
  }

  NameCustomer() {
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
                  controller: customernameController,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(124, 80, 67, 80)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(114, 56, 50, 50),
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

  phoneNumber() {
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
                  onChanged: (value) {},
                  controller: customerphoneNumberController,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(124, 80, 67, 80)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(114, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: screenSize.width / 10,
                child: RoundedLoadingButton(
                  width: 80,
                  loaderSize: 20,
                  successColor: const Color.fromARGB(255, 207, 177, 177),
                  controller: roundloadPhoneController,
                  color: const Color.fromARGB(255, 207, 177, 177),
                  onPressed: _doSomething,
                  child: const Text('Auto Fill!',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  email() {
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
                  onChanged: (value) {},
                  controller: customeremailController,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(124, 80, 67, 80)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(114, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: screenSize.width / 10,
                child: RoundedLoadingButton(
                  width: 80,
                  loaderSize: 20,
                  successColor: const Color.fromARGB(255, 207, 177, 177),
                  controller: roundloademailController,
                  color: const Color.fromARGB(255, 207, 177, 177),
                  onPressed: _doSomething,
                  child: const Text('Auto Fill!',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  address() {
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
                  onChanged: (value) {},
                  controller: customeraddressController,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(124, 80, 67, 80)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(114, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  nid() {
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
                    "NID Number: ",
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
                  onChanged: (value) {},
                  controller: customernidController,
                  enabled: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(137, 54, 35, 35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(124, 80, 67, 80)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(114, 56, 50, 50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: screenSize.width / 10,
                child: RoundedLoadingButton(
                  width: 80,
                  loaderSize: 20,
                  successColor: const Color.fromARGB(255, 207, 177, 177),
                  controller: roundloadnidController,
                  color: const Color.fromARGB(255, 207, 177, 177),
                  onPressed: _doSomething,
                  child: const Text('Auto Fill!',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _doSomething() async {
    Timer(const Duration(seconds: 3), () {
      roundloadPhoneController.success();
    });
  }
}
