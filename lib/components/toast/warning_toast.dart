import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';

class WarningToast extends StatelessWidget {
  WarningToast({@required this.title});

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
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(width: 5, color: metaYellow),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            title,
                            style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
