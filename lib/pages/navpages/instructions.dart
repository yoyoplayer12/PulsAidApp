import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:video_player/video_player.dart';

class Video {
  final String title;
  final String credits;
  final String filePath;
  final String thumbnailPath;
  Video(
      {required this.title,
      required this.credits,
      required this.filePath,
      required this.thumbnailPath});
}

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  List<Video> videos = [
    Video(
        title: 'How to use an AED',
        credits: 'Het Rode Kruis',
        filePath: 'assets/videos/aed.mp4',
        thumbnailPath: 'assets/images/thumbnails/aed.png'),
    Video(
        title: 'CPR',
        credits: 'Het Rode Kruis',
        filePath: 'assets/videos/cpr.mp4',
        thumbnailPath: 'assets/images/thumbnails/cpr.png'),
    Video(
        title: 'How to check conciousness and breathing',
        credits: 'Het Rode Kruis',
        filePath: 'assets/videos/bewustzijn_ademhaling_controleren.mp4',
        thumbnailPath: 'assets/images/thumbnails/bewustzijn.png'),
    Video(
        title: 'Stabiele zijligging',
        credits: 'Het Rode Kruis',
        filePath: 'assets/videos/stabiele_zijligging.mp4',
        thumbnailPath: 'assets/images/thumbnails/zijligging.png'),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                  path: videos[index].filePath),
                            ),
                          );
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width *
                                    0.05), // 5% of screen width
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.9, // 90% of screen width
                                    height: 188,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            videos[index].thumbnailPath),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.darken,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          videos[index].title,
                                          style: const TextStyle(
                                            color: Color(0xFFF8F9FC),
                                            fontSize: 20,
                                            fontFamily: 'Proxima Soft',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Credits: ${videos[index].credits}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  const VideoPlayerScreen({Key? key, required this.path}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft
      ],
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
