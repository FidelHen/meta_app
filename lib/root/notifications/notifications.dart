import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          'Notifications',
          style: appBarTextStyle,
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Shimmer.fromColors(
                baseColor: metaYellow,
                highlightColor: metaRed,
                child: Icon(EvaIcons.globe2Outline)),
            onPressed: () {},
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 0) {
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
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1535223289827-42f1e9919769?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                            color: metaLightBlue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: Faker().internet.userName(),
                                    style: GoogleFonts.sourceCodePro(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text: ' wants to be your friend',
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
                                            borderSide:
                                                BorderSide(color: metaGreen),
                                            highlightedBorderColor:
                                                Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Accept',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 36,
                                        child: OutlineButton(
                                          onPressed: () {},
                                          borderSide:
                                              BorderSide(color: metaRed),
                                          highlightedBorderColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Decline',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
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
            } else if (index % 3 == 0) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1535223289827-42f1e9919769?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                            color: metaLightBlue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: Faker().internet.userName(),
                                    style: GoogleFonts.sourceCodePro(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
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
                                            borderSide:
                                                BorderSide(color: metaYellow),
                                            highlightedBorderColor:
                                                Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'View',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
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
            } else {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
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
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                            color: metaLightBlue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: 'Meta',
                                    style: GoogleFonts.sourceCodePro(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' recommends checking out this upcoming tournament',
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
                                            borderSide: BorderSide(
                                              color: metaYellow,
                                            ),
                                            highlightedBorderColor:
                                                Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'View',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
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
          }),
    );
  }
}
