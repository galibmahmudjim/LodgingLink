import 'package:flutter/material.dart';
import 'package:lodginglink/Receptionist/topBar.dart';

import '../Profile/User.dart';

class RoomReception extends StatefulWidget {
  final User user;
  const RoomReception({Key? key, required this.user}) : super(key: key);

  @override
  State<RoomReception> createState() => _RoomReceptionState();
}

class _RoomReceptionState extends State<RoomReception> {
  bool isLoading = false;

  updateLoad(bool load) {
    setState(() {
      isLoading = load;
      print(load);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: topBar(
          user: widget.user,
          screenName: "Room",
          updateload: updateLoad,
          context: context),
        body: Container(),
    );
  }
}
