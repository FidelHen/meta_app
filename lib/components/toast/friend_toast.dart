import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class FriendToast extends StatelessWidget {
  FriendToast({@required this.onView});

  //Variables
  final Function onView;

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
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: metaRed,
                          period: Duration(milliseconds: 800),
                          direction: ShimmerDirection.ttb,
                          child: Container(
                            width: 5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Friend request',
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
