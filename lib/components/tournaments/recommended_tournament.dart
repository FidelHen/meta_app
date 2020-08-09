import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/screens/tag_view.dart';
import 'package:meta_app/screens/tournaments/tournament_preview.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';
import 'package:meta_app/utils/navigation.dart';

class RecommendedTournament extends StatelessWidget {
  //TODO: Finish the constructor
  //Constructor
  RecommendedTournament(
      {@required this.game,
      @required this.hasJoined,
      @required this.tournamentImageUrl,
      @required this.tags,
      @required this.timestamp,
      @required this.tournamentType,
      @required this.title});

  //Varaibles
  final String title;
  final GamertagPlatform game;
  final List<String> tags;
  final String tournamentImageUrl;
  final String timestamp;
  final bool hasJoined;
  final TournamentType tournamentType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation().segue(
            page: TournamentPreview(), context: context, fullScreen: false);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(tournamentImageUrl ?? ''), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(getPlatformImage(platform: game), scale: 25),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.0, 0.7],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Joined',
                          style: GoogleFonts.openSans(
                              color: metaGreen, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          ' • ',
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          timestamp,
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tags.length,
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
                                        tags[index],
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
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
