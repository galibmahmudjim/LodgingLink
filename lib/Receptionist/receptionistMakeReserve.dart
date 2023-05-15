import 'dart:async';
import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lodginglink/Receptionist/roomReception.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Profile/Customer.dart';
import '../Profile/User.dart';
import '../obj/Reservation.dart';
import '../obj/Room.dart';
import '../restApi/rest.dart';
import '../widget/loading.dart';

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
  var roomnumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var screenSize;
  var roomNumberKey;
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

  DateTime dateofbirthdate = DateTime.now();

  FocusNode field1 = FocusNode();
  FocusNode field2 = FocusNode();
  FocusNode field3 = FocusNode();
  FocusNode field4 = FocusNode();
  FocusNode field5 = FocusNode();
  FocusNode field6 = FocusNode();
  FocusNode field7 = FocusNode();
  FocusNode field8 = FocusNode();
  FocusNode field9 = FocusNode();

  var totalpaymentController = TextEditingController();

  var paymentController = TextEditingController();

  var dueamountController = TextEditingController();

  var items = ['Cash', 'Online'];

  String paymentmethoditem = "Cash";

  //! custome
  String CustomerID = "";
  String Name = "";
  String PhoneNumber = "";
  String Email = "";
  String Address = "";
  String NID = "";
  String DateofBirth = "";

  //!reservation

  String ReservationID = "";
  String ReservationDate = "";
  String DurationofStay = "";
  String CheckInDate = "";
  String CheckOutDate = "";
  String TotalRoom = "1";
  String RoomNumber = "";
  String DuePayment = "";
  String TotalAmmount = "";
  String PaymentMethod = "";
  String payment = "";
  String ReservationStatus = "";
  //!end
  var roomnumberpreviewController = TextEditingController();
  var resevationidpreviewController = TextEditingController();
  var checkindatepreviewController = TextEditingController();
  var checkoutdatepreviewController = TextEditingController();
  var durationpreviewController = TextEditingController();
  var customernamepreviewController = TextEditingController();
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
  var reservationdatepreviewController = TextEditingController();
  var totalroompreviewController = TextEditingController();
  var reservationstatuspreviewController = TextEditingController();

  String nidbuttontext = "Auto Fill";
  String emailbuttontext = "Auto Fill";
  String phonebuttontext = "Auto Fill";

//!var

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalpaymentController.text = widget.room.roomRate.toString();
    setState(() {
      isLoading = false;
      paymentController.text = "0";
      dueamountController.text =
          (int.parse(totalpaymentController.text.toString()) -
                  int.parse(paymentController.text.toString()))
              .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    roomnumberController.text = widget.room.roomNumber.toString();

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
        child: SingleChildScrollView(child: Center(child: reservationForm())),
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
    return isLoading
        ? Column(
            children: const [
              SizedBox(
                height: 100,
              ),
              loading()
            ],
          )
        : Container(
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
                                    int.parse(durationofstaycontroller.text
                                            .toString()) >
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
                            content: paymentreserve(),
                            isActive: (_currentStep >= 2),
                            state: (_currentStep > 2)
                                ? StepState.complete
                                : StepState.disabled),
                        Step(
                            title: const Text(
                              "Preview",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            content: preview(),
                            isActive: (_currentStep >= 3),
                            state: (_currentStep > 3)
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
      if (_currentStep == 0 &&
          int.parse(durationofstaycontroller.text.toString()) < 1) {
        Fluttertoast.showToast(
          msg: "Please enter check-in check-out date correctly",
          gravity: ToastGravity.TOP,
          fontSize: 40,
          webPosition: "center",
          webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
        );
      } else if (_currentStep == 1 &&
          (customernameController.text.toString().isEmpty ||
              customerphoneNumberController.text.toString().isEmpty ||
              customeremailController.text.toString().isEmpty ||
              customeraddressController.text.toString().isEmpty ||
              customernidController.text.toString().isEmpty ||
              DateTime.now().year - dateofbirthdate.year < 18)) {
        if (customernameController.text.toString().isEmpty) {
          field1.requestFocus();
          Fluttertoast.showToast(
            msg: "Enter Customer Name",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (customerphoneNumberController.text.toString().isEmpty) {
          field2.requestFocus();
          Fluttertoast.showToast(
            msg: "Enter Phone Number",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (customeremailController.text.toString().isEmpty) {
          field3.requestFocus();
          Fluttertoast.showToast(
            msg: "Enter Email",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (customeraddressController.text.toString().isEmpty) {
          field4.requestFocus();
          Fluttertoast.showToast(
            msg: "Enter Email",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (customernidController.text.toString().isEmpty) {
          field5.requestFocus();
          Fluttertoast.showToast(
            msg: "Enter NID number",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        } else if (DateTime.now().year - dateofbirthdate.year < 18) {
          field4.requestFocus();
          Fluttertoast.showToast(
            msg: "Age under 18",
            gravity: ToastGravity.TOP,
            fontSize: 40,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
          );
        }
      } else if (dueamountController.text.isEmpty && _currentStep == 2) {
        setState(() {
          dueamountController.text = "0";
          _currentStep++;
        });
      } else if (_currentStep < 3) {
        setState(() {
          _currentStep++;
          if (_currentStep == 3) initvalue();
        });
        if (_currentStep == 2) {
          totalpaymentController.text =
              (int.parse(durationofstaycontroller.text.toString()) *
                      int.parse(widget.room.roomRate.toString()))
                  .toString();
        }
      } else if (_currentStep == 3) {
        AddReservation();
      }
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
                : (_currentStep == 3)
                    ? const Text("Submit")
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
                  controller: roomnumberController,
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
          setState(() {
            if (value.difference(checkindate).inDays < 1) {
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

              totalpaymentController.text =
                  (int.parse(durationofstaycontroller.text.toString()) *
                          int.parse(widget.room.roomRate.toString()))
                      .toString();
              dueamountController.text =
                  (int.parse(totalpaymentController.text.toString()) -
                          int.parse(paymentController.text.toString()))
                      .toString();
            });
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
                      height: 2,
                    ),
                    phoneNumber(),
                    const SizedBox(
                      height: 2,
                    ),
                    email(),
                    const SizedBox(
                      height: 2,
                    ),
                    address(),
                    const SizedBox(
                      height: 2,
                    ),
                    nid(),
                    const SizedBox(
                      height: 2,
                    ),
                    dob(),
                    const SizedBox(
                      height: 30,
                    ),
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
                  onChanged: (value) {
                    roundloadPhoneController.reset();
                  },
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
                  onPressed: getDataPhoneNumber,
                  child: Text(phonebuttontext,
                      style: const TextStyle(color: Colors.white)),
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
                  focusNode: field3,
                  onFieldSubmitted: (value) {
                    field4.requestFocus();
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  onChanged: (value) {
                    emailbuttontext = "Auto Fill";
                    roundloademailController.reset();
                  },
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
                  onPressed: getDateEmail,
                  child: Text(emailbuttontext,
                      style: const TextStyle(color: Colors.white)),
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
                  focusNode: field4,
                  onFieldSubmitted: (value) {
                    field5.requestFocus();
                  },
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
                  focusNode: field5,
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  onChanged: (value) {
                    roundloadnidController.reset();
                  },
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
                  onPressed: getDataNid,
                  child: Text(nidbuttontext,
                      style: const TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dob() {
    return Row(
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
          child: dobdatefield(),
        )
      ],
    );
  }

  dobdatefield() {
    return DateTimeField(
        lastDate: DateTime.now(),
        mode: DateTimeFieldPickerMode.date,
        dateTextStyle: const TextStyle(
          fontFamily: "Railway",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        decoration: const InputDecoration(
            hintText: 'Pick Date of Birth date',
            prefixIcon: Icon(Icons.calendar_month),
            prefixIconColor: Color.fromARGB(137, 0, 0, 0)),
        selectedDate: dateofbirthdate,
        onDateSelected: (DateTime value) {
          setState(() {
            dateofbirthdate = value;
          });
        });
  }

  void _doSomething() async {
    Timer(const Duration(seconds: 3), () {
      roundloadPhoneController.success();
    });
  }

//! payment step

  paymentreserve() {
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
                    TotalAmount(),
                    const SizedBox(
                      height: 10,
                    ),
                    Payment(),
                    const SizedBox(
                      height: 10,
                    ),
                    dueAmmount(),
                    const SizedBox(
                      height: 10,
                    ),
                    paymentmethod(),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
          ),
        ));
  }

  TotalAmount() {
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
                    "Total Amount: ",
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
                  focusNode: field6,
                  onFieldSubmitted: (value) {
                    field7.requestFocus();
                  },
                  onChanged: (value) {
                    setState(() {
                      dueamountController.text = (int.parse(value.toString()) -
                              int.parse(paymentController.text.toString()))
                          .toString();
                    });
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: totalpaymentController,
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

  Payment() {
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
                  focusNode: field7,
                  onFieldSubmitted: (value) {
                    field8.requestFocus();
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        value = "0";
                      }

                      dueamountController.text =
                          (int.parse(totalpaymentController.text.toString()) -
                                  int.parse(value))
                              .toString();
                    });
                  },
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: paymentController,
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

  dueAmmount() {
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
                    "Due: ",
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
                  controller: dueamountController,
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

  paymentmethod() {
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
                    "Total Amount: ",
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
                  value: paymentmethoditem,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      paymentmethoditem = newValue!;
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

//!preview step
  initvalue() {
    //customer id
    CustomerID = customernameController.text
            .toUpperCase()
            .replaceAll(" ", "")
            .substring(0, 3) +
        customerphoneNumberController.text.toString().substring(
            customerphoneNumberController.text.toString().length - 3,
            customerphoneNumberController.text.toString().length);
    Name = customernameController.text.toString();
    PhoneNumber = customerphoneNumberController.text.toString();
    Email = customeremailController.text;
    Address = customeraddressController.text;
    NID = customernidController.text;
    DateofBirth = DateFormat("dd-MM-yyyy").format(dateofbirthdate);
    //reservation
    RoomNumber = roomnumberController.text;
    ReservationDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    ReservationID =
        CustomerID + RoomNumber + DateTime.now().toString().replaceAll('-', '');
    DurationofStay = durationofstaycontroller.text;
    CheckInDate = DateFormat('dd-MM-yyyy').format(checkindate);
    CheckOutDate = DateFormat('dd-MM-yyyy').format(checkoutdate);
    TotalAmmount = totalpaymentController.text;
    DuePayment = dueamountController.text;
    payment = paymentController.text;
    PaymentMethod = paymentmethoditem.toString();
    ReservationStatus = "Reserved";
    //pass
    setState(() {
      roomnumberpreviewController.text = RoomNumber;
      resevationidpreviewController.text = ReservationID;
      checkindatepreviewController.text = CheckInDate;
      checkoutdatepreviewController.text = CheckOutDate;
      durationpreviewController.text = DurationofStay;
      customernamepreviewController.text = Name;
      customeridpreviewController.text = CustomerID;
      phonenumberpreviewController.text = PhoneNumber;
      emailpreviewController.text = Email;
      addresspreviewController.text = Address;
      nidpreviewController.text = NID;
      dobpreviewController.text = DateofBirth;
      totalammountpreviewController.text = TotalAmmount;
      paymentpreviewController.text = payment;
      dueammountpreviewController.text = DuePayment;
      paymentmethodpreviewController.text = PaymentMethod;
      reservationdatepreviewController.text = ReservationDate;
      totalroompreviewController.text = TotalRoom;
      reservationstatuspreviewController.text = ReservationStatus;
    });
  }

  preview() {
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
                child: TextFormField(
                  style: const TextStyle(
                    fontFamily: "Railway",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  controller: reservationstatuspreviewController,
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

  Future<void> AddReservation() async {
    setState(() {
      isLoading = true;
    });
    Customer customer;
    Reservation reservation;

    customer = Customer(
        customerID: CustomerID,
        name: Name,
        phoneNumber: PhoneNumber,
        email: Email,
        address: Address,
        NID: NID,
        dateOfBirth: DateofBirth);
    reservation = Reservation(
        reservationID: ReservationID,
        reservationDate: ReservationDate,
        durationOfStay: int.parse(DurationofStay),
        checkInDate: CheckInDate,
        checkOutDate: CheckOutDate,
        customerID: CustomerID,
        totalRoom: int.parse(TotalRoom),
        roomNumber: RoomNumber,
        duePayment: int.parse(DuePayment),
        totalAmmount: int.parse(TotalAmmount),
        paymentMethod: PaymentMethod,
        Payment: int.parse(payment),
        reservationStatus: ReservationStatus);
    Response? response = await Rest.addCustomer(customer.toJson());
    Response? response1 = await Rest.addReservation(reservation.toJson());
    var msg = 'Dear ' +
        customer.name.toString() +
        "\nReservation Complete\n+Room no:" +
        reservation.roomNumber.toString() +
        "\nReservation ID: " +
        reservation.reservationID.toString() +
        "\nCheck-In Date: " +
        reservation.checkInDate.toString() +
        "\n-LodgingLink\nThank you....";
    if (response!.statusCode == 200 && response1!.statusCode == 200) {
      var sms = {
        'api_key': 'AXzd054su9N208p2mas73Hv0FH53jeG8sfeAt44k',
        'msg': msg,
        'to': customer.phoneNumber.toString()
      };
      Response? response = await Rest.sendsms(sms);
      print(response!.body);
      Fluttertoast.showToast(
        msg: "Reservation Complete",
        gravity: ToastGravity.TOP,
        fontSize: 40,
        webPosition: "center",
        webBgColor: "linear-gradient(to right, #ABB900, #ABB900)",
      );
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => RoomReception(user: widget.user))));
    }
  }

  Future<void> getDataPhoneNumber() async {
    var phone = {"PhoneNumber": customerphoneNumberController.text};
    Response? response = await Rest.getCustomerPhone(phone);
    if (response!.statusCode == 201) {
      roundloadPhoneController.stop();
      setState(() {
        phonebuttontext = "Not Found";
      });
    } else {
      Customer customer = Customer.fromJson(jsonDecode(response.body));

      roundloadPhoneController.success();

      setState(() {
        customernameController.text = customer.name.toString();
        customerphoneNumberController.text = customer.phoneNumber.toString();
        customeremailController.text = customer.email.toString();
        customeraddressController.text = customer.address.toString();

        DateFormat dateFormat = DateFormat('dd-MM-yyyy');
        DateTime dateTime = dateFormat.parse(customer.dateOfBirth.toString());
        dateofbirthdate = dateTime;
        customernidController.text = customer.NID.toString();
      });
    }
  }

  Future<void> getDataNid() async {
    var nid = {"NID": customernidController.text};
    Response? response = await Rest.getCustomerNid(nid);
    if (response!.statusCode == 201) {
      roundloadnidController.stop();
      setState(() {
        nidbuttontext = "Not Found";
      });
    } else {
      Customer customer = Customer.fromJson(jsonDecode(response.body));
      roundloadnidController.success();

      setState(() {
        customernameController.text = customer.name.toString();
        customerphoneNumberController.text = customer.phoneNumber.toString();
        customeremailController.text = customer.email.toString();
        customeraddressController.text = customer.address.toString();

        DateFormat dateFormat = DateFormat('dd-MM-yyyy');
        DateTime dateTime = dateFormat.parse(customer.dateOfBirth.toString());
        dateofbirthdate = dateTime;
      });
    }
  }

  Future<void> getDateEmail() async {
    var email = {"Email": customeremailController.text};
    Response? response = await Rest.getCustomerEmail(email);
    if (response!.statusCode == 201) {
      roundloadnidController.stop();
      setState(() {
        emailbuttontext = "Not Found";
      });
    } else {
      Customer customer = Customer.fromJson(jsonDecode(response.body));
      roundloademailController.success();

      setState(() {
        customernidController.text = customer.NID.toString();
        customernameController.text = customer.name.toString();
        customerphoneNumberController.text = customer.phoneNumber.toString();
        customeremailController.text = customer.email.toString();
        customeraddressController.text = customer.address.toString();
        DateFormat dateFormat = DateFormat('dd-MM-yyyy');
        DateTime dateTime = dateFormat.parse(customer.dateOfBirth.toString());
        dateofbirthdate = dateTime;
      });
    }
  }
}
