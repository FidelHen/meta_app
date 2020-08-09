import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/screens/intro/login.dart';
import 'package:meta_app/screens/intro/sign_up.dart';
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
  //Variables
  TextStyle titleTextStyle = GoogleFonts.sourceCodePro(
      color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700);
  TextStyle descriptionTextStyle = GoogleFonts.openSans(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300);

  EdgeInsets infoPadding = EdgeInsets.fromLTRB(25, 5, 25, 15);

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
                return exploreSlide();
              } else if (index == 1) {
                return tournamentsSlide();
              } else if (index == 2) {
                return relaxSlide();
              } else {
                return Container();
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
        floatingActionButton: rightFAB(
          title: 'Sign up',
          onPressed: () {
            Navigation()
                .segue(page: SignUp(), context: context, fullScreen: false);
          },
        ));
  }

  //Widgets
  Widget exploreSlide() {
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
                style: titleTextStyle,
              ),
              Padding(
                padding: infoPadding,
                child: Text(
                  'Find friends to play with online',
                  textAlign: TextAlign.center,
                  style: descriptionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tournamentsSlide() {
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
                style: titleTextStyle,
              ),
              Padding(
                padding: infoPadding,
                child: Text(
                  'Join daily tournaments for prizes or just for the adrenaline',
                  textAlign: TextAlign.center,
                  style: descriptionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget relaxSlide() {
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
                style: titleTextStyle,
              ),
              Padding(
                padding: infoPadding,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          'We will do the hard work for you as long as you follow the ',
                      style: descriptionTextStyle,
                      children: [
                        TextSpan(
                          text: 'Meta',
                          style: descriptionTextStyle.copyWith(
                              fontWeight: FontWeight.w800),
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
}
