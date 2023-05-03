import 'package:flutter/material.dart';
import 'package:lodginglink/Profile/User.dart';

class homePageReception extends StatefulWidget {
  const homePageReception({Key? key, required User user}) : super(key: key);

  @override
  State<homePageReception> createState() => _homePageReceptionState();
}

class _homePageReceptionState extends State<homePageReception> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
      title: const Text('My App'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Add search functionality here
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Add notifications functionality here
          },
        ),
      ],
    ));
  }
}
