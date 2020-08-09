import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:meta_app/screens/tag_view.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';
import 'package:meta_app/utils/navigation.dart';

class UpcomingTournament extends StatefulWidget {
  //Constructor
  UpcomingTournament(
      {@required this.game,
      @required this.hasJoined,
      @required this.tournamentImageUrl,
      @required this.tags,
      @required this.timestamp,
      @required this.isNotified,
      @required this.tournamentType,
      @required this.title});

  //Varaibles
  final String title;
  final GamertagPlatform game;
  final List<String> tags;
  final String tournamentImageUrl;
  final String timestamp;
  final bool hasJoined;
  final bool isNotified;
  final TournamentType tournamentType;

  @override
  _UpcomingTournamentState createState() => _UpcomingTournamentState();
}

class _UpcomingTournamentState extends State<UpcomingTournament> {
  //Variables
  bool isNotified;

  @override
  void initState() {
    isNotified = widget.isNotified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        height: DeviceSize().getHeight(context) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(widget.tournamentImageUrl ?? ''),
              fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: DeviceSize().getHeight(context) / 3,
            width: DeviceSize().getWidth(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
                stops: [0.0, 0.8],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(getPlatformImage(platform: widget.game),
                          scale: 25),
                      LikeButton(
                        size: 25,
                        onTap: onNotificationButtonTapped,
                        circleColor:
                            CircleColor(start: metaRed, end: metaYellow),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.white,
                          dotSecondaryColor: metaYellow,
                        ),
                        isLiked: false,
                        likeBuilder: (bool currentlyBookmarked) {
                          return Icon(
                            currentlyBookmarked
                                ? EvaIcons.bell
                                : EvaIcons.bellOutline,
                            color:
                                currentlyBookmarked ? metaYellow : Colors.white,
                            size: 27,
                          );
                        },
                        countBuilder: (int count, bool isLiked, String text) {
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Solo/Team entry',
                            style: GoogleFonts.openSans(
                                color: metaYellow, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' • ',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.timestamp,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 25,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.tags.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigation().segue(
                                        page: Tag(),
                                        context: context,
                                        fullScreen: false);
                                  },
                                  child: Container(
                                    height: 25,
                                    constraints: BoxConstraints(minWidth: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Center(
                                        child: Text(
                                          widget.tags[index],
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<bool> onNotificationButtonTapped(bool isLiked) async {
    // Vibrate.feedback(FeedbackType.medium);
    if (!isLiked) {
      // Social().bookmarkPost(postUid: widget.postUid);
    } else {
      // Social().unBookmarkPost(postUid: widget.postUid);
    }
    return !isLiked;
  }
}
