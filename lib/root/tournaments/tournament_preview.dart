import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/invite_modal.dart';
import 'package:meta_app/utils/colors.dart';
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
      length: 3,
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
                GoogleFonts.sourceCodePro(fontWeight: FontWeight.w500),
            labelStyle: GoogleFonts.sourceCodePro(fontWeight: FontWeight.w600),
            indicatorColor: metaGreen,
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "Bracket"),
              Tab(text: "Leaderboard"),
            ],
          ),
        ),
        backgroundColor: metaDarkBlue,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [overviewTab(), bracketTab(), leaderboardTab()]),
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
        Padding(
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
                  'Starts in:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  '00:00:00',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Prize:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Shimmer.fromColors(
                  baseColor: metaYellow,
                  highlightColor: metaRed,
                  child: Text(
                    '1 Month subscription',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Game mode:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  'Highest kills',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Spots remaining:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  '1 team',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Tournament style:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  'Bracket',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Platform:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  'All platforms',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
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
                  'Team size:',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  'Duos (1-2 players)',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
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
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            'Championship',
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
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
                      style: GoogleFonts.sourceCodePro(
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
        ),
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
                                  backgroundImage: NetworkImage(
                                      'https://source.unsplash.com/1600x900/?person'),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    Faker().internet.userName(),
                                    style: GoogleFonts.sourceCodePro(
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
                            Icon(
                              EvaIcons.arrowUp,
                              color: metaGreen,
                            ),
                            Text(' ${index + 1}',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
