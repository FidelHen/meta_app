import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/screens/intro/landing.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  //Hive
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  //Hive box's
  await Hive.openBox('profile');

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Only portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //White status bar
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return OverlaySupport(
      child: MaterialApp(
        title: 'Meta',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: OverscrollBehavior(),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            splashColor: Colors.transparent,
            backgroundColor: metaDarkBlue,
            cursorColor: metaGreen,
            accentColor: Colors.transparent),
        home: Landing(),
      ),
    );
  }
}

class OverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
