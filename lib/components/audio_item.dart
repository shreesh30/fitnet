import 'package:flutter/material.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:video_player/video_player.dart';


class AudioItem extends StatefulWidget {

   AudioItem({@required this.videoPlayerController, this.looping});

  final VideoPlayerController videoPlayerController;
  final bool looping;

  @override
  _AudioItemState createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  ChewieAudioController _chewieAudioController;


  @override
  void initState() {
    super.initState();
    _chewieAudioController=ChewieAudioController(
      videoPlayerController: widget.videoPlayerController,
      autoPlay: false,
      autoInitialize: true,
      looping: widget.looping,
       errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage, style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieAudioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ChewieAudio(
        controller: _chewieAudioController,
      ),
    );
  }
}