import 'package:flutter/material.dart';
import 'package:lodginglink/Profile/User.dart';
import 'package:lodginglink/Receptionist/appbarcontentItem.dart';
import 'package:lodginglink/Receptionist/topBar.dart';
import 'package:lodginglink/widget/loading.dart';

class homePageReception extends StatefulWidget {
  final User user;
  const homePageReception({Key? key, required this.user}) : super(key: key);

  @override
  State<homePageReception> createState() => _homePageReceptionState();
}

class _homePageReceptionState extends State<homePageReception> {
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
    return Center(
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
            child: appbarcontent(
                user: widget.user, context: context, screenSize: screenSize)),
      ),
    );
  }
}
