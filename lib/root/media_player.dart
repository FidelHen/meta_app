import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaPlayer extends StatefulWidget {
  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  //Variables
  bool videoIsExpanded;

  //Youtube controller
  YoutubePlayerController youtubeController;

  @override
  void initState() {
    //Variables
    videoIsExpanded = false;

    //Youtube controller
    youtubeController = YoutubePlayerController(
      initialVideoId: 'OBhb2ep-crM',
      flags: YoutubePlayerFlags(autoPlay: true, enableCaption: false),
    );

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
                bottomActions: [],
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
                actions: [
                  IconButton(
                    onPressed: () {
                      //Video expansion
                      videoIsExpanded
                          ? SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp])
                          : SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight
                            ]);
                      videoIsExpanded = !videoIsExpanded;
                      Future.delayed(Duration(milliseconds: 150)).then((value) {
                        youtubeController.play();
                      });
                    },
                    icon: Icon(
                      EvaIcons.expand,
                      color: Colors.white,
                    ),
                  ),
                ],
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ));
  }
}
