import 'package:flutter/material.dart';
import 'package:lodginglink/Receptionist/roomReception.dart';

import '../Profile/User.dart';

class appbarcontent extends StatefulWidget {
  final BuildContext context;
  final User user;
  const appbarcontent(
      {Key? key,
      required this.screenSize,
      required this.context,
      required this.user})
      : super(key: key);

  final Size screenSize;

  @override
  _appbarcontentState createState() => _appbarcontentState();
}

class _appbarcontentState extends State<appbarcontent> {
  final List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];

  List<String> items = ['Room', 'Reservation', 'Customer', 'History'];
  List<IconData> icons = [
    Icons.location_on,
    Icons.date_range,
    Icons.people,
    Icons.wb_sunny
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
          if (i == 0) {
            Navigator.push(
                widget.context,
                MaterialPageRoute(
                    builder: (context) => RoomReception(
                          user: widget.user,
                        )));
          }
        },
        child: Text(
          items[i],
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: _isHovering[i]
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(133, 10, 10, 10),
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: generateRowElements(),
          )),
    );
  }
}
