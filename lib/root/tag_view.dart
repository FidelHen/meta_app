import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/root/media_player.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class Tag extends StatefulWidget {
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
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
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          '#Warzone',
          style: appBarTextStyle,
        ),
      ),
      body: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigation().segue(
                                  page: MediaPlayer(),
                                  context: context,
                                  fullScreen: false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/originals/f4/4e/a3/f44ea3c617af231a1ac21eb02189162b.jpg'),
                                    fit: BoxFit.cover),
                              ),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          trailing: GestureDetector(
                            onTap: () {},
                            child: Icon(EvaIcons.moreVertical,
                                color: Colors.white),
                          ),
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('images/temp_avatar.png')),
                          title: Text(
                            'Fidelhen',
                            style: GoogleFonts.sourceCodePro(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 25,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 20,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      height: 25,
                                      constraints: BoxConstraints(minWidth: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: metaLightBlue),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        child: Center(
                                          child: Text(
                                            Faker().lorem.word(),
                                            style: GoogleFonts.openSans(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Container(
                  height: DeviceSize().getHeight(context) / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://www.pcgamesn.com/wp-content/uploads/2020/03/lol_fiddlesticks_new_update_2020.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('images/league_logo.png',
                                        scale: 25),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        icon: Icon(EvaIcons.bellOutline),
                                        onPressed: () {},
                                      ),
                                    )
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
                                      '5v5',
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
                                              color: metaYellow,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          ' • ',
                                          style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Starts in 2 mins',
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
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: Container(
                                                height: 25,
                                                constraints: BoxConstraints(
                                                    minWidth: 50),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                                  child: Center(
                                                    child: Text(
                                                      'Warzone',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
            },
          ),
        ],
      ),
    );
  }
}
