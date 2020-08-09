import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/clip_modal.dart';
import 'package:meta_app/components/modals/clip_owner_modal.dart';
import 'package:meta_app/screens/media_player.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class VideoClip extends StatefulWidget {
  //Constructor
  VideoClip(
      {@required this.username,
      @required this.profileImageUrl,
      @required this.tags,
      @required this.previewImageUrl,
      @required this.isOwner,
      @required this.clipPlatform,
      @required this.videoUrl});

  //Variables
  final String username;
  final String previewImageUrl;
  final String profileImageUrl;
  final String videoUrl;
  final ClipPlatform clipPlatform;
  final bool isOwner;
  final List<String> tags;

  @override
  _VideoClipState createState() => _VideoClipState();
}

class _VideoClipState extends State<VideoClip> {
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
                  Navigation().segue(
                      page: MediaPlayer(
                        videoUrl: widget.videoUrl ?? '',
                      ),
                      context: context,
                      fullScreen: false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(widget.previewImageUrl ?? ''),
                        fit: BoxFit.cover),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                  ),
                ),
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
                    showClipOwnerModal(context: context);
                  } else {
                    showClipModal(context: context);
                  }
                },
                child: Icon(EvaIcons.moreVertical, color: Colors.white),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.profileImageUrl != null
                      ? NetworkImage(widget.profileImageUrl ?? '')
                      : AssetImage('images/temp_avatar.png')),
              title: Text(
                widget.username,
                style: clipUsernameTextStyle,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
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
}
