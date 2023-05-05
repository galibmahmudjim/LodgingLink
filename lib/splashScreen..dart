import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lodginglink/widget/videoControl.dart';

import 'HomePage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: <Widget>[
        const backgroundVideo(),
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LodgingLink',
          home: splash(),
        )
      ])),
    );
  }

  splash() {
    return AnimatedSplashScreen(
      duration: 1000,
      splash: Image.asset('assets/logo/logo.png'),
      centered: true,
      splashIconSize: double.maxFinite * 0.1,
      nextScreen: const HomePage(),
      backgroundColor: Colors.transparent,
    );
  }
}
