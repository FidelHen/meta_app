import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class MessageTile extends StatelessWidget {
  //Constructor
  MessageTile(
      {@required this.message,
      @required this.profileImageUrl,
      @required this.isOwner,
      @required this.previouslyMessaged,
      @required this.timestamp});

  //Variables
  final String message;
  final String timestamp;
  final String profileImageUrl;
  final bool isOwner;
  final bool previouslyMessaged;

  @override
  Widget build(BuildContext context) {
    if (!isOwner) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            profileImage(),
            Expanded(
              child: messageContent(),
            ),
            SizedBox(
              width: DeviceSize().getWidth(context) / 12,
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: DeviceSize().getWidth(context) / 12,
            ),
            Expanded(
              child: messageContent(),
            ),
            profileImage(),
          ],
        ),
      );
    }
  }

  //Widgets
  Widget profileImage() {
    return Padding(
      padding:
          EdgeInsets.only(right: !isOwner ? 8.0 : 0, left: isOwner ? 8.0 : 0),
      child: CircleAvatar(
        backgroundColor: previouslyMessaged ? metaDarkBlue : Colors.grey,
        backgroundImage: previouslyMessaged
            ? null
            : profileImageUrl != null
                ? NetworkImage(profileImageUrl ?? '')
                : AssetImage('images/temp_avatar.png'),
      ),
    );
  }

  Widget messageContent() {
    return Column(
      crossAxisAlignment:
          isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        previouslyMessaged
            ? Container()
            : Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  timestamp,
                  style: messagesTileTimestampTextStyle,
                ),
              ),
        Container(
          constraints: BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
              color: isOwner ? metaLightBlue : Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message ?? '',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.openSans(
                      color: isOwner ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
