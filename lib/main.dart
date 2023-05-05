import 'package:flutter/material.dart';
import 'package:lodginglink/splashScreen..dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
