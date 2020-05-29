import 'package:flutter/material.dart';
import 'package:fitnet/components/video_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({this.url});
  final String url;
  static const String id='video_screen';
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return VideoItem(
      videoPlayerController: VideoPlayerController.network(widget.url),
      looping: false,
    );
  }
}
