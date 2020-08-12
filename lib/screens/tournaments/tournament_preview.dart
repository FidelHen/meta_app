import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/invite_modal.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class TournamentPreview extends StatefulWidget {
  @override
  _TournamentPreviewState createState() => _TournamentPreviewState();
}

class _TournamentPreviewState extends State<TournamentPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'images/cod_mw_logo.png',
            scale: 30,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              EvaIcons.chevronLeft,
              color: Colors.white,
              size: 40,
            ),
          ),
          backgroundColor: metaDarkBlue,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(EvaIcons.questionMarkCircleOutline),
                onPressed: () {},
                color: Colors.white,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle:
                GoogleFonts.robotoMono(fontWeight: FontWeight.w500),
            labelStyle: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
            indicatorColor: metaGreen,
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "Bracket"),
            ],
          ),
        ),
        backgroundColor: metaDarkBlue,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [overviewTab(), bracketTab()]),
            ),
            Container(
              color: metaDarkBlue,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: FloatingActionButton.extended(
                          heroTag: 'invite',
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          onPressed: () {
                            inviteModal(context: context);
                          },
                          label: Padding(
                            padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Invite',
                                    style: fabButtonTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FloatingActionButton.extended(
                          backgroundColor: metaYellow,
                          onPressed: () {},
                          label: Padding(
                            padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Join',
                                      style: fabButtonTextStyle.copyWith(
                                        color: Colors.white,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Tab bar views
  Widget overviewTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 8,
        ),
        descriptionLabel(
          title: 'Starts in:',
          trailing: '00:00:00',
          isPro: false,
        ),
        descriptionLabel(
          title: 'Prize:',
          trailing: '1 Month subscription',
          isPro: true,
        ),
        descriptionLabel(
          title: 'Game mode:',
          trailing: 'Highest kills',
          isPro: false,
        ),
        descriptionLabel(
          title: 'Spots remaining:',
          trailing: '1 team',
          isPro: false,
        ),
        descriptionLabel(
          title: 'Tournament style:',
          trailing: 'Bracket',
          isPro: false,
        ),
        descriptionLabel(
          title: 'Platform:',
          trailing: 'All platforms',
          isPro: false,
        ),
        descriptionLabel(
          title: 'Team size:',
          trailing: 'Duos (1-2 players)',
          isPro: false,
        ),
      ],
    );
  }

  Widget bracketTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 8,
        ),
        bracketTitle(title: 'Championship'),
        bracketLabel(),
      ],
    );
  }

  Widget leaderboardTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 8,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 50,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return leaderboardLabel(
                profileImageUrl: 'https://source.unsplash.com/1600x900/?person',
                username: Faker().internet.userName(),
                positionIndicator: LeaderboardPositionIndicator.Positive,
                index: index);
          },
        ),
      ],
    );
  }

  //Widgets
  Widget descriptionLabel(
      {@required String title,
      @required String trailing,
      @required bool isPro}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: metaLightBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: ListTile(
            title: Text(
              title ?? '',
              style: GoogleFonts.openSans(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: isPro
                ? Shimmer.fromColors(
                    baseColor: metaYellow,
                    highlightColor: metaRed,
                    child: Text(
                      trailing,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Text(
                    trailing ?? '',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget leaderboardLabel(
      {@required String profileImageUrl,
      @required String username,
      @required LeaderboardPositionIndicator positionIndicator,
      @required int index}) {
    Widget icon = Container();
    //Conditionals
    if (positionIndicator == LeaderboardPositionIndicator.Negative) {
      icon = Icon(
        EvaIcons.arrowDown,
        color: metaRed,
      );
    } else if (positionIndicator == LeaderboardPositionIndicator.Positive) {
      icon = Icon(
        EvaIcons.arrowUp,
        color: metaGreen,
      );
    } else if (positionIndicator == LeaderboardPositionIndicator.Neutral) {
      icon = Icon(
        EvaIcons.arrowUp,
        color: Colors.transparent,
      );
    }

    return GestureDetector(
      onTap: () {},
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl ?? '')
                              : AssetImage('images/temp_avatar.png'),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            username ?? '',
                            style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    icon,
                    Text(' ${index + 1}',
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w700))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bracketTitle({@required String title}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: GoogleFonts.openSans(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget bracketLabel() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: metaLightBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    );
                  }),
              Text('VS',
                  style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
