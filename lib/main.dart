import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/screens/intro/landing.dart';
import 'package:meta_app/screens/screen_loader.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  //Hive
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  await Hive.openBox('profile');

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    String host = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';

    Firestore.instance
        .settings(host: host, sslEnabled: false, persistenceEnabled: false);

    super.initState();
  }

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
        home: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ScreenLoader(
                checkData: false,
              );
            } else {
              if (snapshot.data != null) {
                return ScreenLoader(
                  checkData: true,
                );
              } else {
                return Landing();
              }
            }
          },
        ),
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
