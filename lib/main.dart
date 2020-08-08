import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:meta_app/root/root.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
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
        home: Root(),
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
