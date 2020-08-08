import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';

class NotificationInvite extends StatelessWidget {
  //Constructor
  NotificationInvite({
    @required this.username,
    @required this.profileImageUrl,
  });

  //Varaibles
  final String username;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileImage(),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                  color: metaLightBlue, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: username,
                          style: GoogleFonts.sourceCodePro(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: ' invited you to a tournament',
                              style: GoogleFonts.sourceCodePro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 36,
                                child: OutlineButton(
                                  onPressed: () {},
                                  borderSide: BorderSide(color: metaYellow),
                                  highlightedBorderColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'View',
                                      style: profileActionButtonTextStlye,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
  Widget profileImage() {
    if (profileImageUrl != null) {
      return Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.white, // border color
            shape: BoxShape.circle,
            border: new Border.all(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: metaDarkBlue,
            backgroundImage: AssetImage('images/meta_logo.png'),
          ),
        ),
      );
    }
  }
}
