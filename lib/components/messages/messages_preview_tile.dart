import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/root/messages/messages_view.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class MessagesPreviewTile extends StatelessWidget {
  //Constructor
  MessagesPreviewTile(
      {@required this.message,
      @required this.opened,
      @required this.profileImageUrl,
      @required this.timestamp,
      @required this.username});

  //Variables
  final String username;
  final String profileImageUrl;
  final String timestamp;
  final String message;
  final bool opened;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation()
            .segue(page: MessagesView(), context: context, fullScreen: false);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Container(
          decoration: BoxDecoration(
            color: metaLightBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl ?? '')
                      : AssetImage('images/temp_avatar.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: opened ? Colors.transparent : metaGreen,
                        shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            username,
                            style: clipUsernameTextStyle,
                          ),
                          Text(
                            timestamp,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        message ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(color: Colors.white70),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
