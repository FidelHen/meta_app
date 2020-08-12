import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationFriend extends StatefulWidget {
  //Constructor
  NotificationFriend(
      {@required this.username,
      @required this.profileImageUrl,
      @required this.hasOpened});

  //Varaibles
  final String username;
  final String profileImageUrl;
  final bool hasOpened;

  @override
  _NotificationFriendState createState() => _NotificationFriendState();
}

class _NotificationFriendState extends State<NotificationFriend> {
  //Variables
  bool hasAccepted;

  @override
  void initState() {
    //Variables
    hasAccepted = widget.hasOpened;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.profileImageUrl != null
                      ? NetworkImage(widget.profileImageUrl ?? '')
                      : AssetImage('images/temp_avatar.png'),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                  color: metaLightBlue, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: widget.username,
                          style: GoogleFonts.robotoMono(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: ' wants to be your friend',
                              style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: actionButton(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Widgets
  Widget actionButton() {
    return Container(
      height: 36,
      child: OutlineButton(
        onPressed: () {
          if (!hasAccepted) {
            showOverlayNotification((context) {
              return SuccessToast(
                title: 'Sucessfully accepted',
              );
            });
          }

          setState(() {
            hasAccepted = !hasAccepted;
          });
        },
        borderSide: BorderSide(color: hasAccepted ? Colors.white : metaGreen),
        highlightedBorderColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            hasAccepted ? 'Accepted' : 'Accept',
            style: profileActionButtonTextStlye,
          ),
        ),
      ),
    );
  }
}
