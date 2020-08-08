import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaPlayer extends StatefulWidget {
  //Constructor
  MediaPlayer({@required this.videoUrl});

  //Variables
  final String videoUrl;

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  //Variables
  bool videoIsExpanded;
  String videoId;

  //Youtube controller
  YoutubePlayerController youtubeController;

  @override
  void initState() {
    //Variables
    videoIsExpanded = false;
    //Functions
    startVideo();
    super.initState();
  }

  @override
  void dispose() {
    //Landscape mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                controller: youtubeController,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(
                    playedColor: metaRed,
                    handleColor: metaRed,
                    backgroundColor: Colors.white38),
                bufferIndicator: SpinKitChasingDots(
                  color: Colors.white,
                  size: 50.0,
                ),
                onReady: () {},
              ),
            ),
            Container(
              height: 80,
              child: AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    EvaIcons.chevronLeft,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ));
  }

  //Functions
  void startVideo() {
    //Variables
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    //Youtube controller
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: true, enableCaption: false),
    );
  }
}
