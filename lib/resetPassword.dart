import 'package:flutter/material.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/homeBackground.jpg"), fit: BoxFit.cover),
      ),
      child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text("This is reset password"),
          )),
    );
  }
}
