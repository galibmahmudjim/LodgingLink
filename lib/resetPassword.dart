import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lodginglink/Receptionist/homePageReception.dart';
import 'package:lodginglink/restApi/rest.dart';

import 'Profile/User.dart';

class resetPassword extends StatefulWidget {
  final User user;
  const resetPassword({Key? key, required this.user}) : super(key: key);

  @override
  State<resetPassword> createState() => _resetPasswordState(user);
}

class _resetPasswordState extends State<resetPassword> {
  final formkey = GlobalKey<FormState>();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  String? passveriferror;
  User? user;

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  FocusNode field1 = FocusNode();
  FocusNode field2 = FocusNode();
  FocusNode button1 = FocusNode();

  _resetPasswordState(user) {
    this.user = user;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/homeBackground.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0),
              child: Form(
                key: formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      nameWelcomeFieldText(),
                      Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.3,
                            right: MediaQuery.of(context).size.width * 0.3,
                          ),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 50, left: 50, right: 50),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(99, 165, 172, 170),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ), //BorderRadius.all
                          ),
                          child: Column(children: [
                            homePageTitle(),
                            passwordTextfiels(),
                            verifypasswordTextfiels(),
                            submitbutton(),
                          ]))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //!home page logo
  Center homePageLogo() {
    return Center(
      child: Image.asset(
        'assets/logo/logo.png',
        height: 300,
        width: 500,
        fit: BoxFit.cover,
      ),
    );
  }

  nameWelcomeFieldText() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 100),
      child: Text(
        "Hello ${widget.user.UserID}",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins-Black.ttf",
            fontSize: 50,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ));
  }

  //!user initial cookies

  passwordTextfiels() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        focusNode: field1,
        onFieldSubmitted: (value) =>
            {FocusScope.of(context).requestFocus(field2)},
        keyboardType: TextInputType.visiblePassword,
        controller: password1,
        obscureText: _obscureText1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            FocusScope.of(context).requestFocus(field1);
            return 'Please Enter Valid passrword';
          } else if (value.length < 8) {
            FocusScope.of(context).requestFocus(field1);
            return 'Password must be at least 8 character.';
          } else if (value == widget.user.Password) {
            FocusScope.of(context).requestFocus(field1);
            return 'Do not enter your previous Password';
          }
          return null;
        },
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
        onChanged: (value) {},
        decoration: InputDecoration(
            errorStyle: const TextStyle(color: Color.fromARGB(255, 44, 3, 0)),
            labelText: "Password",
            labelStyle: const TextStyle(color: Colors.black45),
            prefixIcon: const Icon(Icons.lock, color: Colors.black45),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
              color: Colors.black12,
              onPressed: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
            ),
            focusColor: Colors.black45,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 2)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            )),
      ),
    );
  }

  homePageTitle() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.only(
        bottom: 50,
      ),
      child: Text(
        "Reset Password",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins-Black.ttf",
            fontSize: 30,
            color: Color.fromARGB(115, 26, 22, 22)),
      ),
    ));
  }

  verifypasswordTextfiels() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: TextFormField(
        focusNode: field2,
        onFieldSubmitted: (value) =>
            {FocusScope.of(context).requestFocus(button1)},
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        keyboardType: TextInputType.visiblePassword,
        controller: password2,
        obscureText: _obscureText2,
        validator: (value) {
          if (value == null || value.isEmpty) {
            FocusScope.of(context).requestFocus(field1);
            return 'Please enter same passrword';
          }
          return null;
        },
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
        onChanged: (value) {
          passveriferror = "";
        },
        decoration: InputDecoration(
            errorText: passveriferror,
            errorStyle: const TextStyle(color: Color.fromARGB(255, 44, 3, 0)),
            labelText: "Confirm Password",
            labelStyle: const TextStyle(color: Colors.black45),
            prefixIcon: const Icon(Icons.lock, color: Colors.black45),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
              color: Colors.black12,
              onPressed: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
            ),
            focusColor: Colors.black45,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 2)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            )),
      ),
    );
  }

//!submit button
  Padding submitbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        focusNode: button1,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(50, 50),
          backgroundColor: const Color.fromARGB(159, 106, 118, 132),
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 128, 177, 193),
              fontSize: 25,
              fontStyle: FontStyle.normal),
        ),
        onPressed: () {
          verifyassword(password1.text, password2.text);
        },
        child: const Text('Reset Password'),
      ),
    );
  }

  void verifyassword(text, text2) {
    if (formkey.currentState!.validate()) {
      if (password1.text != password2.text) {
        setState(() {
          passveriferror = "Not same password";
          FocusScope.of(context).requestFocus(field1);
        });
      } else {
        updatePassword(text);
      }
    }
  }

  void updatePassword(text) async {
    var response =
        await Rest.updatePassword(widget.user.UserID, text, "Active");
    if (response!.statusCode == 200) {
      passwordResetSuccessfulToast(jsonDecode(response.body)["Message"]);
      if (widget.user.Role == "Receptionist") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => homePageReception(user: widget.user)));
      }
    } else {
      errorToast(jsonDecode(response.body)["Message"]);
    }
  }
}

//! Password reset success toast
void passwordResetSuccessfulToast(String stat) {
  Fluttertoast.showToast(
    msg: stat,
    gravity: ToastGravity.TOP,
    fontSize: 40,
    webPosition: "center",
    webBgColor: "linear-gradient(to right, #ABB900, #ABB900)",
  );
}

//!error password reset toast
void errorToast(String stat) {
  Fluttertoast.showToast(
    msg: stat,
    gravity: ToastGravity.TOP,
    fontSize: 40,
    webPosition: "center",
    webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
  );
}
