import 'package:fitnet/components/audio_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioScreen extends StatefulWidget {
  static const String id = 'audio_screen';
  AudioScreen({this.url});
  final String url;
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

   @override
  void dispose() {
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return AudioItem(
      videoPlayerController: VideoPlayerController.network(widget.url),
      looping: false,
    );
  }
}
