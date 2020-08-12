import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';

void showGoProModal({@required context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: DeviceSize().getHeight(context) * .9,
          decoration: BoxDecoration(
            color: metaLightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  right: DeviceSize().getWidth(context) * 0.02,
                  left: DeviceSize().getWidth(context) * 0.02,
                  top: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Go meta pro for premium features',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoMono(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: Swiper(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: FlareActor(
                                                  "flares/meta_orbit.flr",
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.fitHeight,
                                                  animation: "rotate"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 15, 25, 15),
                                                  child: Text(
                                                    'Experience our whole gaming network',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (index == 1) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: FlareActor(
                                                  "flares/meta_swords.flr",
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.fitHeight,
                                                  animation: "animate"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 15, 25, 15),
                                                  child: Text(
                                                    'Join unlimited tournaments with friends',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: FlareActor(
                                                "flares/meta_shrink_planet.flr",
                                                alignment: Alignment.center,
                                                fit: BoxFit.fitHeight,
                                                animation: "animate"),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 15, 25, 15),
                                                child: Text(
                                                  'No more limits on finding gamers and explore people’s orbit',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: 3,
                                  autoplay: true,
                                  autoplayDelay: 5000,
                                  viewportFraction: 1,
                                  pagination: SwiperPagination(
                                      builder: new DotSwiperPaginationBuilder(
                                          color: Colors.grey,
                                          activeColor: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Transform.translate(
                              offset: Offset(-8, 12),
                              child: Container(
                                width: 220,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    'images/sparks_icon.png',
                                    scale: 6,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                              child: FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                onPressed: () {},
                                label: Container(
                                  width: 130,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: '\$1.99',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                children: [
                                                  TextSpan(
                                                    text: '/mo',
                                                    style: GoogleFonts.openSans(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Image.asset(
                                              'images/rocket_icon.png',
                                              scale: 6,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
