import 'package:flutter/material.dart';
import 'package:lodginglink/splashScreen..dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/homeBackground.jpg"), fit: BoxFit.cover),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LodgingLink',
        home: splashScreen(),
      ),
    );
  }
}
