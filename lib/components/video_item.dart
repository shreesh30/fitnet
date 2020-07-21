import 'package:fitnet/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoItem extends StatefulWidget {
  VideoItem({
    @required this.videoPlayerController,
    this.looping,
  });

  final VideoPlayerController videoPlayerController;
  final bool looping;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      // fullScreenByDefault: true,
      // showControlsOnInitialize: false,
      // showControls: widget.url==null?false:true,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
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
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Padding(
        padding: EdgeInsets.all(0),
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
    // return  Padding(
    //     padding: EdgeInsets.all(0),
    //     child: Chewie(
    //       controller: _chewieController,
    //     ),
    //   );
  }
}
