import 'package:flutter/material.dart';

class topBar extends StatefulWidget implements PreferredSizeWidget {
  const topBar({Key? key})
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
                  width: screenSize.width / 4,
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
      onTap: () {},
      onHover: (value) {
        setState(() {
          _isHovering[1] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 24,
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
      onTap: () {},
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
              fontSize: 24,
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
    return Container(
      color: Colors.transparent,
      height: 70,
      width: 70,
      child: Image.asset("assets/logo/logo2.png"),
    );
  }

  AppBarName() {
    return const Text(
      'LodgningLink',
      style: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 26,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w900,
        letterSpacing: 3,
      ),
    );
  }

  AppBarHome() {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          _isHovering[0] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Home',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: _isHovering[0]
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
