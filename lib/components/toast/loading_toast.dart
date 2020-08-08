import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class LoadingToast extends StatelessWidget {
  LoadingToast({@required this.title});

  //Variables
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: metaLightBlue,
              height: 60,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              title,
                              style: GoogleFonts.sourceCodePro(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FlatButton(
                            onPressed: () {
                              OverlaySupportEntry.of(context).dismiss();
                            },
                            child: Text(
                              'Dismiss',
                              style: smallButtonTextStyle,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.white24,
                    valueColor: new AlwaysStoppedAnimation<Color>(metaGreen),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
