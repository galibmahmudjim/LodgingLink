import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Utils/sharedPref.dart';
import 'package:lodginglink/resetPassword.dart';
import 'package:lodginglink/restApi/rest.dart';

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
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homePageLogo(),
                    loginEmailTextformfield(),
                    loginPasswordTextformfield(),
                    loginbutton()
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
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5 - 200.0,
          right: MediaQuery.of(context).size.width * 0.5 - 200,
          bottom: 10),
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
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5 - 200.0,
          right: MediaQuery.of(context).size.width * 0.5 - 200,
          bottom: 10),
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
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5 - 200.0,
          right: MediaQuery.of(context).size.width * 0.5 - 200,
          top: 20.0),
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const resetPassword()));
        Navigator.pop(context);
  }

//!inital login token
  Future<void> initToken() async {
    token = await sharedPref.getString();
    var response = await Rest.tokenProfile(token);
    if (response!.statusCode == 200) {
      var profile = await jsonDecode(response.body);
      user = User(profile['authdata']['User']['UserID']);
      await user.initialize();
      if (user.Status == "pass_init") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const resetPassword()));
             Navigator.pop(context);
      }
    }
  }
}
