import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class shimmer extends StatefulWidget {
  const shimmer({Key? key}) : super(key: key);

  @override
  State<shimmer> createState() => _shimmerState();
}

class _shimmerState extends State<shimmer> {

  @override
  Widget build(BuildContext context) {
    print('true');
    return Shimmer(
      color: Colors.white, //Default value
      colorOpacity: 1, //Default value
      enabled: true, //Default value
      child: Container(
        color: Colors.transparent,
        child: Image.asset("assets/logo/logo2.png"),
      ),
    );
  }
}
