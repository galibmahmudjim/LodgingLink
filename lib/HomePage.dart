import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Utils/sharedPref.dart';
import 'package:lodginglink/resetPassword.dart';
import 'package:lodginglink/restApi/rest.dart';

import 'Receptionist/homePageReception.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _obscureText = true;
  late User user;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final homepagePasswordKey = GlobalKey<FormState>();
  final homepageEmailKey = GlobalKey<FormState>();
  final formkey = GlobalKey<FormState>();
  String? token = "";
  @override
  void initState() {
    super.initState();
    initToken();
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
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3,
                        right: MediaQuery.of(context).size.width * 0.3,
                      ),
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 30, left: 50, right: 50),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(99, 165, 172, 170),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), //BorderRadius.all
                      ),
                      child: Column(children: [
                        homePageLogo(),
                        loginEmailTextformfield(),
                        loginPasswordTextformfield(),
                        loginbutton()
                      ]),
                    ),
                  ],
                ),
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

//!email login text form
  Padding loginEmailTextformfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        key: homepageEmailKey,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter valid Email';
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: "Enter USERID",
            labelStyle: TextStyle(color: Colors.black45),
            prefixIcon: Icon(Icons.email, color: Colors.black45),
            focusColor: Colors.black45,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 2)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 2.0),
            )),
      ),
    );
  }

//!password login text form
  Padding loginPasswordTextformfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Valid password';
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
            labelText: "Password",
            labelStyle: const TextStyle(color: Colors.black45),
            prefixIcon: const Icon(Icons.lock, color: Colors.black45),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              color: Colors.black12,
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
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

//!login button
  Padding loginbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white38,
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
        ),
        onPressed: () {
          loginAuth(emailController.text, passwordController.text);
        },
        child: const Text('Login'),
      ),
    );
  }

//! login success toast
  void loginSuccessfulToast(String stat) {
    Fluttertoast.showToast(
      msg: stat,
      gravity: ToastGravity.TOP,
      fontSize: 40,
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #ABB900, #ABB900)",
    );
  }

//!error login toast
  void errorToast(String stat) {
    Fluttertoast.showToast(
      msg: stat,
      gravity: ToastGravity.TOP,
      fontSize: 40,
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #BB4400, #BB4400)",
    );
  }

//!login auth
  void loginAuth(String text, String text2) async {
    if (formkey.currentState!.validate()) {
      var response = await Rest.loginAPI(text, text2);
      dynamic data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        user = User(text);
        user.initialize();
        loginSuccessful(data);
      } else {
        errorToast(data["Message"]);
      }
    }
  }

//!successfull login
  void loginSuccessful(dynamic data) async {
    sharedPref.setString(data['token']);
    loginSuccessfulToast(data['Message']);
    print(user.UserID);
    if (user.Role == "Receptionist") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => resetPassword(user: user)));
    }
  }

//!inital login token
  Future<void> initToken() async {
    User? user = await sharedPref.tokenUser();
    print(user!.Status);
    if (user.Status == "pass_init") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => resetPassword(user: user)));
    } else if (user.Role == "Receptionist") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => homePageReception(user: user)));
    }
  }
}
