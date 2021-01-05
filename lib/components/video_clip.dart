import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/clip_modal.dart';
import 'package:meta_app/components/modals/clip_owner_modal.dart';
import 'package:meta_app/screens/media_player.dart';
import 'package:meta_app/screens/web_view.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoClip extends StatefulWidget {
  //Constructor
  VideoClip(
      {@required this.username,
      @required this.profileImageUrl,
      @required this.tags,
      @required this.thumbnailUrl,
      @required this.isOwner,
      @required this.clipPlatform,
      @required this.videoUid,
      this.deleteCallback,
      @required this.videoUrl});

  //Variables
  final String username;
  final String thumbnailUrl;
  final String profileImageUrl;
  final String videoUrl;
  final ClipPlatform clipPlatform;
  final bool isOwner;
  final List<String> tags;
  final String videoUid;
  final Function deleteCallback;

  @override
  _VideoClipState createState() => _VideoClipState();
}

class _VideoClipState extends State<VideoClip> {
  //Variables
  YoutubePlayerController youtubeVideoController;

  @override
  void initState() {
    if (widget.clipPlatform == ClipPlatform.Youtube) {
      getYoutubeVideo(url: widget.videoUrl);
    }
    super.initState();
  }

  @override
  void dispose() {
    //YoutubeController
    if (youtubeVideoController != null) {
      youtubeVideoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.clipPlatform == ClipPlatform.Youtube) {
                    Navigation().segue(
                        page: MediaPlayer(
                          videoUrl: widget.videoUrl ?? '',
                        ),
                        context: context,
                        fullScreen: false);
                  } else {
                    Navigation().segue(
                        page: WebView(title: 'Clip', url: widget.videoUrl),
                        context: context,
                        fullScreen: false);
                  }
                },
                child: getThumbnail(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              trailing: GestureDetector(
                onTap: () {
                  if (widget.isOwner) {
                    showClipOwnerModal(
                        context: context,
                        callback: widget.deleteCallback,
                        videoUid: widget.videoUid);
                  } else {
                    showClipModal(context: context);
                  }
                },
                child: Icon(EvaIcons.moreVertical, color: Colors.white),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.profileImageUrl != ''
                      ? NetworkImage(widget.profileImageUrl ?? '')
                      : AssetImage('images/temp_avatar.png')),
              title: Text(
                widget.username,
                style: clipUsernameTextStyle,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: widget.tags.length == 0
                    ? Container(
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                height: 25,
                                constraints: BoxConstraints(minWidth: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: metaLightBlue),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Center(
                                    child: Text(
                                      'No tags',
                                      style: clipTagsTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.tags.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 25,
                                  constraints: BoxConstraints(minWidth: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: metaLightBlue),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Center(
                                      child: Text(
                                        widget.tags[index],
                                        style: clipTagsTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getYoutubeVideo({@required String url}) {
    //Variables
    String youtubeVideoId = YoutubePlayer.convertUrlToId(url);

    //Youtube controller
    youtubeVideoController = YoutubePlayerController(
      initialVideoId: youtubeVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: true,
        enableCaption: false,
        hideControls: true,
      ),
    );
  }

  //widget
  Widget getThumbnail() {
    if (widget.clipPlatform == ClipPlatform.Youtube) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(
            controller: youtubeVideoController,
            showVideoProgressIndicator: true,
            bottomActions: [],
            progressColors: ProgressBarColors(
                playedColor: metaRed,
                handleColor: metaRed,
                backgroundColor: Colors.white38),
            topActions: [],
          ),
        ),
      );
    } else {
      if (widget.thumbnailUrl != '') {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(widget.thumbnailUrl ?? ''),
                fit: BoxFit.cover),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            color: twitchPurple,
          ),
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                  child: Text('No thumbnail',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )))),
        );
      }
    }
  }
}
