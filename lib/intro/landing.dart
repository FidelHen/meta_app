import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/intro/login.dart';
import 'package:meta_app/intro/sign_up.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:flare_flutter/flare_actor.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          FlatButton(
            onPressed: () {
              Navigation()
                  .segue(page: Login(), context: context, fullScreen: true);
            },
            child: Text(
              'Log in',
              style: smallButtonTextStyle,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
          ),
        ],
      ),
      backgroundColor: metaDarkBlue,
      body: Container(
        height: DeviceSize().getHeight(context) - 200,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: FlareActor("flares/meta_space.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          animation: "animate"),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          'Explore',
                          style: GoogleFonts.sourceCodePro(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Text(
                            'Find friends to play with online',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (index == 1) {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(80, 20, 80, 25),
                      child: Image.asset(
                        "images/landing_2.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          'Tournaments',
                          style: GoogleFonts.sourceCodePro(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Text(
                            'Join daily tournaments for prizes or just for the adrenaline',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: FlareActor("flares/meta_super_saiyan.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                          animation: "animate"),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          'Relax',
                          style: GoogleFonts.sourceCodePro(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    'We will do the hard work for you as long as you follow the ',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                                children: [
                                  TextSpan(
                                    text: 'Meta',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
          itemCount: 3,
          autoplay: true,
          autoplayDelay: 5000,
          viewportFraction: 1,
          pagination: SwiperPagination(
              builder: new DotSwiperPaginationBuilder(
                  color: Colors.grey, activeColor: Colors.white)),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigation()
                .segue(page: SignUp(), context: context, fullScreen: false);
          },
          label: Row(children: [
            Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Text(
                'Sign up',
                style: fabButtonTextStyle,
              ),
            ),
            Icon(
              EvaIcons.chevronRight,
              color: Colors.black,
            ),
          ]),
        ),
      ),
    );
  }
}
