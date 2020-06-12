import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';

void showPlatformModal({@required context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: DeviceSize().getHeight(context) * 0.8,
          decoration: BoxDecoration(
            color: metaLightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                right: DeviceSize().getWidth(context) / 10,
                left: DeviceSize().getWidth(context) / 10,
                top: 25),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        platformButton(
                            context: context,
                            image: 'playstation_logo.png',
                            platform: 'Playstation'),
                        platformButton(
                            context: context,
                            image: 'xbox_logo.png',
                            platform: 'Xbox'),
                        platformButton(
                            context: context,
                            image: 'pc_logo.png',
                            platform: 'PC/Mac'),
                        platformButton(
                            context: context,
                            image: 'league_logo.png',
                            platform: 'League of Legends'),
                        platformButton(
                            context: context,
                            image: 'cod_mw_logo.png',
                            platform: 'COD: Warzone'),
                        platformButton(
                            context: context,
                            image: 'fortnite_logo.png',
                            platform: 'Fortnite'),
                        platformButton(
                            context: context,
                            image: 'mobile_logo.png',
                            platform: 'Mobile'),
                        platformButton(
                            context: context,
                            image: 'switch_logo.png',
                            platform: 'Nintendo Switch'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget platformButton(
    {@required context, @required String image, @required String platform}) {
  return Container(
    height: DeviceSize().getWidth(context),
    child: RaisedButton(
      onPressed: () {},
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: metaLightBlue,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/$image'),
              color: metaGreen,
              height: DeviceSize().getWidth(context) * 0.1,
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                platform,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14),
              ),
            )
          ]),
    ),
  );
}
