import 'package:flutter/material.dart';
import 'package:lodginglink/Receptionist/AboutUS.dart';
import 'package:lodginglink/Receptionist/homePageReception.dart';
import 'package:lodginglink/Utils/sharedPref.dart';
import 'package:lodginglink/widget/loading.dart';

import '../HomePage.dart';
import '../Profile/User.dart';

class topBar extends StatefulWidget implements PreferredSizeWidget {
  final User user;
  final String screenName;
  final void Function(bool) updateload;
  final BuildContext context;
  const topBar(
      {Key? key,
      required this.user,
      required this.screenName,
      required this.updateload,
      required this.context})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _topBarState createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        color: const Color.fromARGB(143, 110, 102, 102).withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(children: [
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                AppBarLogo(),
                AppBarName(),
                SizedBox(
                  width: screenSize.width / 3.5,
                ),
                AppBarHome(),
                SizedBox(
                  width: screenSize.width / 4,
                ),
                contactUs(),
                SizedBox(
                  width: screenSize.width / 20,
                ),
                logOut(),
              ]),
            )
          ]),
        ));

    //);
  }

  contactUs() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AboutUS(user: widget.user)));
      },
      onHover: (value) {
        setState(() {
          _isHovering[1] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'About Us',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: _isHovering[1]
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(133, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 5),
          // For showing an underline on hover
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _isHovering[1],
            child: Container(
              height: 2,
              width: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  logOut() {
    return InkWell(
      onTap: () {
        print("yes");
        showDialog<String>(
          context: widget.context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Logout!'),
            content: const Text('Are you sure?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.pop(context, 'OK'),
                  Navigator.pushReplacement(widget.context,
                      MaterialPageRoute(builder: (context) => const loading())),
                  sharedPref.deleteToken(),
                  Navigator.pushReplacement(widget.context,
                      MaterialPageRoute(builder: (context) => HomePage())),
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      onHover: (value) {
        setState(() {
          _isHovering[2] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: _isHovering[2]
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(133, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 5),
          // For showing an underline on hover
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _isHovering[2],
            child: Container(
              height: 2,
              width: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  AppBarLogo() {
    return InkWell(
      child: Container(
        color: Colors.transparent,
        height: 60,
        width: 70,
        child: Image.asset("assets/logo/logo2.png"),
      ),
      onTap: () {
        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:
            (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
          return homePageReception(
            user: widget.user,
          );
        }));
      },
    );
  }

  AppBarName() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:
            (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
          return homePageReception(
            user: widget.user,
          );
        }));
      },
      child: const Text(
        "LodgingLink",
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),
      ),
    );
  }

  AppBarHome() {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isHovering[0] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.screenName,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 5),
          // For showing an underline on hover
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _isHovering[0],
            child: Container(
              height: 2,
              width: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
