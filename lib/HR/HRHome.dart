import 'package:flutter/material.dart';
import 'package:lodginglink/HR/topBar.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/widget/loading.dart';

import 'appbarcontentItem.dart';

class HRHome extends StatefulWidget {
  final User user;
  const HRHome({Key? key, required this.user}) : super(key: key);

  @override
  State<HRHome> createState() => _HRHomeState();
}

class _HRHomeState extends State<HRHome> {
  bool isLoading = false;

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return isLoading
        ? const loading()
        : Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(60.0), // here the desired height
              child: topBar(
                user: widget.user,
                screenName: "Home",
                updateload: updateLoad,
                context: context,
              ),
            ),
            body: Stack(
              children: [
                cardBar(screenSize),
              ],
            ),
          );
  }

  cardBar(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.only(
              top: screenSize.height / 8,
              left: screenSize.width / 5,
              right: screenSize.width / 5,
            ),
            child: Card(
                elevation: 4,
                color: const Color.fromARGB(163, 255, 255, 255),
                child: appbarcontentHR(
                    user: widget.user, context: context, screenSize: screenSize)),
          ),
        ),
      ],
    );
  }
}
