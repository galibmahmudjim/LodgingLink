import 'package:flutter/material.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class homePageReception extends StatefulWidget {
  const homePageReception({Key? key, required User user}) : super(key: key);

  @override
  State<homePageReception> createState() => _homePageReceptionState();
}

class _homePageReceptionState extends State<homePageReception> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(150.0), // here the desired height
          child: topBar(),
        ), );
  }

  cardBar(Size screenSize) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.40,
          left: screenSize.width / 5,
          right: screenSize.width / 5,
        ),
        child: const Card(
          color: Color.fromARGB(163, 255, 255, 255),
        ),
      ),
    );
  }
}
