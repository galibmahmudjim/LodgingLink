import 'package:flutter/material.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/widget/videoControl.dart';

class homePageReception extends StatefulWidget {
  const homePageReception({Key? key, required User user}) : super(key: key);

  @override
  State<homePageReception> createState() => _homePageReceptionState();
}

class _homePageReceptionState extends State<homePageReception> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: const [
          backgroundVideo(),
          //appBar(),
        ],)
        );
  }
  
  appBar() {

  }
}
