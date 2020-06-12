import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/intro/landing.dart';
import 'package:meta_app/root/settings/report_problem.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.chevronDown,
            color: Colors.white,
            size: 40,
          ),
        ),
        title: Text(
          'Settings',
          style: appBarTextStyle,
        ),
        backgroundColor: metaDarkBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: DeviceSize().getWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    listTile(
                        isPro: false,
                        title: 'Report a problem',
                        onPressed: () {
                          Navigation().segue(
                              page: ReportProblem(),
                              context: context,
                              fullScreen: false);
                        }),
                    listTile(
                        isPro: false,
                        title: 'Terms & Conditions',
                        onPressed: () {}),
                    listTile(
                        isPro: false,
                        title: 'Change password',
                        onPressed: () {}),
                    listTile(isPro: true, title: 'Go Pro', onPressed: () {}),
                  ],
                ),
              ),
              Container(
                child: FlatButton(
                    onPressed: () {
                      Navigation().segueToRoot(
                          page: Landing(), context: context, fullScreen: true);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Logout',
                      style: smallButtonTextStyle,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listTile(
      {@required bool isPro,
      @required String title,
      @required Function onPressed}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Container(
        color: !isPro ? metaLightBlue : metaRed,
        width: DeviceSize().getWidth(context),
        child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.only(
              right: DeviceSize().getWidth(context) * 0.02,
              left: DeviceSize().getWidth(context) * 0.06,
            ),
            child: Container(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      EvaIcons.chevronRight,
                      size: 35,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
