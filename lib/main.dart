import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LodgingLink',
        home: AnimatedSplashScreen(
          duration: 000,
          splash:Image.asset('assets/logo/logo.png'),
          centered: true,
          splashIconSize: double.maxFinite*0.1,
          nextScreen: const HomePage(),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

