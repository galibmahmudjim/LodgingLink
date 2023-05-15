import 'package:flutter/material.dart';
import 'package:lodginglink/Receptionist/topBar.dart';

import '../Profile/User.dart';
import '../widget/loading.dart';

class AboutUS extends StatefulWidget {
  final User user;
  const AboutUS({Key? key, required this.user}) : super(key: key);

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
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
                screenName: "About Us",
                updateload: updateLoad,
                context: context,
              ),
            ),
            body: Center(
                child: Container(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/about.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            )));
  }
}
