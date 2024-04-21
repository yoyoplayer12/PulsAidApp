import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/main.dart';
import 'package:theapp/pages/navpages/notifications.dart';
import 'package:video_player/video_player.dart';

class Video {
  final String title;
  final String credits;
  final String filePath;
  final String thumbnailPath;
  Video({required this.title, required this.credits, required this.filePath, required this.thumbnailPath});
}

class Instructions extends StatefulWidget {
  const Instructions({super.key});

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  List<Video> videos = [
    Video(title: 'How to use an AED', credits: 'Het Rode Kruis', filePath: 'assets/videos/aed.mp4', thumbnailPath: 'assets/images/thumbnails/aed.png'),
    Video(title: 'CPR', credits: 'Het Rode Kruis', filePath: 'assets/videos/cpr.mp4', thumbnailPath: 'assets/images/thumbnails/cpr.png'),
    Video(title: 'How to check conciousness and breathing', credits: 'Het Rode Kruis', filePath: 'assets/videos/bewustzijn_ademhaling_controleren.mp4', thumbnailPath: 'assets/images/thumbnails/bewustzijn.png'),
    Video(title: 'Stabiele zijligging', credits: 'Het Rode Kruis', filePath: 'assets/videos/stabiele_zijligging.mp4', thumbnailPath: 'assets/images/thumbnails/zijligging.png'),
    // Add more videos here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppBar(
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context).translate('instructions'),
                    style: const TextStyle(
                      color: BrandColors.grayMid,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset(videos[index].thumbnailPath), // replace with your video thumbnail
                            const Icon(Icons.play_circle_fill, size: 64.0, color:  Color.fromARGB(196, 255, 255, 255)),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(videos[index].title),
                            Text('Credits: ${videos[index].credits}'),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(path: videos[index].filePath),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String path;

  const VideoPlayerScreen({super.key, required this.path});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.path);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Chewie(
                controller: _chewieController,
              ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}