import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:meta_app/root/root.dart';
import 'package:meta_app/utils/colors.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return MaterialApp(
      title: 'Meta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        backgroundColor: metaDarkBlue,
        cursorColor: metaGreen,
      ),
      home: Root(),
    );
  }
}
