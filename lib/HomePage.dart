import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Utils/sharedPref.dart';
import 'package:lodginglink/resetPassword.dart';
import 'package:lodginglink/restApi/rest.dart';
import 'package:lodginglink/widget/loading.dart';
import 'package:lodginglink/widget/videoControl.dart';

import 'Receptionist/homePageReception.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _obscureText = true;
  late User user;

  FocusNode field1 = FocusNode();
  FocusNode field2 = FocusNode();
  FocusNode button1 = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final homepagePasswordKey = GlobalKey<FormState>();
  final homepageEmailKey = GlobalKey<FormState>();
  final formkey = GlobalKey<FormState>();
  String? token = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    initToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/homeBackground.jpg"), fit: BoxFit.cover),
          ),
      child: isLoading
          ? const loading()
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  const backgroundVideo(),
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
                              color: Color.fromARGB(147, 255, 255, 255),
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
    bool isHovering = false;
    Color bgcolor = const Color.fromARGB(84, 255, 255, 255);
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: MouseRegion(
            onEnter: (PointerEvent details) {
              setState(() {
                isHovering = true;
                bgcolor = Colors.white;
                field1.requestFocus();
              });
            },
            onExit: (PointerEvent details) {
              setState(() {
                isHovering = false;
                bgcolor = const Color.fromARGB(84, 255, 255, 255);
                field1.unfocus();
              });
            },
            child: Card(
              elevation: isHovering ? 1000 : 0,
              color: Colors.transparent,
              child: TextFormField(
                focusNode: field1,
                onFieldSubmitted: (value) =>
                    {FocusScope.of(context).requestFocus(field2)},
                key: homepageEmailKey,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid Email';
                  }
                  return null;
                },
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(194, 0, 0, 0),
                ),
                onChanged: (value) {},
                decoration: InputDecoration(
                  fillColor: bgcolor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                  errorStyle: TextStyle(color: Colors.red[900]),
                  labelText: "Enter UserID",
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.black45),
                  focusColor: Colors.black45,
                ),
              ),
            )));
  }

//!password login text form
  Padding loginPasswordTextformfield() {
    bool isHovering = false;
    Color bgcolor = const Color.fromARGB(84, 255, 255, 255);
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: MouseRegion(
          onEnter: (PointerEvent details) {
            setState(() {
              isHovering = true;
              bgcolor = Colors.white;
              field2.requestFocus();
            });
          },
          onExit: (PointerEvent details) {
            setState(() {
              isHovering = false;
              bgcolor = const Color.fromARGB(84, 255, 255, 255);
              field2.unfocus();
            });
          },
          child: Card(
            elevation: isHovering ? 10 : 0,
            color: Colors.transparent,
            child: TextFormField(
              focusNode: field2,
              onFieldSubmitted: (value) =>
                  {FocusScope.of(context).requestFocus(button1)},
              cursorColor: const Color.fromARGB(255, 0, 0, 0),
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  FocusScope.of(context).requestFocus(button1);
                  return 'Password required';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(194, 0, 0, 0),
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                  fillColor: bgcolor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 20),
                  errorStyle: TextStyle(color: Colors.red[900]),
                  labelText: "Password",
                  labelStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.black45),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: InputBorder.none),
            ),
          ),
        ));
  }

//!login button
  Padding loginbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        focusNode: button1,
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
        if (data["Message"] == "UserID not Found") {
          field1.requestFocus();
        } else {
          field2.requestFocus();
        }
      }
      setState(() {
        print(isLoading);
      });
    }
  }

//!successfull login
  void loginSuccessful(dynamic data) async {
    sharedPref.setString(data['token']);
    loginSuccessfulToast(data['Message']);
    await initToken();
  }

//!inital login token
  Future<void> initToken() async {
    User? user = await sharedPref.tokenUser();

    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
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
