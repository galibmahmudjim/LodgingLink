import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class backgroundVideo extends StatefulWidget {
  const backgroundVideo({super.key});

  @override
  State<backgroundVideo> createState() => _backgroundVideoState();
}

class _backgroundVideoState extends State<backgroundVideo> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset("assets/video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
    _controller.setVolume(0.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: FittedBox(
            // If your background video doesn't look right, try changing the BoxFit property.
            // BoxFit.fill created the look I was going for.
            fit: BoxFit.fill,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            )));
  }
}
