import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/components/loading_progress_indicator.dart';
import 'package:meta_app/screens/root.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';

import 'intro/landing.dart';
import 'intro/onboarding/gamertags.dart';

class ScreenLoader extends StatefulWidget {
  //Constructor
  ScreenLoader({@required this.checkData});

  //Variables
  final bool checkData;
  @override
  _ScreenLoaderState createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends State<ScreenLoader> {
  @override
  void initState() {
    //Conditionals
    if (!widget.checkData) {
      getRegistrationData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: metaDarkBlue,
        body: Center(child: LoadingProgressIndicator()),
        bottomNavigationBar: BottomAppBar(
          elevation: 20,
          color: metaLightBlue,
          child: Container(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      EvaIcons.messageSquare,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      EvaIcons.people,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    iconSize: 45,
                    icon: Image.asset(
                      'images/meta_logo.png',
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      EvaIcons.bell,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      EvaIcons.person,
                      color: Colors.grey,
                    ),
                  ),
                ]),
          ),
        ));
  }

  //Functions
  void getRegistrationData() async {
    /*
    * Depending on how authentication becomes implemented, start thinking about just authenticating with Hive
    * because when the app is deleted it will resend them to landing screen, maybe you can add a 
    * continue as *name* screen since they are technically still authenticated
    */

    //Hive
    final box = Hive.box('profile');
    final isRegistered = await box.get('is_registered');

    //Conditionals
    if (isRegistered != null) {
      if (isRegistered) {
        Navigation()
            .fadeSegue(page: Root(), context: context, segueToRoot: true);
      } else {
        Navigation()
            .fadeSegue(page: Gamertags(), context: context, segueToRoot: true);
      }
    } else {
      FirebaseAuth.instance.currentUser().then((value) {
        if (value.uid != null) {
          Firestore.instance
              .collection('users')
              .document(value.uid)
              .get()
              .then((document) {
            if (document.exists) {
              final registered = document.data['is_registered'] ?? false;
              if (registered != null) {
                if (registered) {
                  Navigation().fadeSegue(
                      page: Root(), context: context, segueToRoot: true);
                } else {
                  Navigation().fadeSegue(
                      page: Gamertags(), context: context, segueToRoot: true);
                }
              } else {
                Navigation().fadeSegue(
                    page: Landing(), context: context, segueToRoot: true);
              }
            } else {
              Navigation().fadeSegue(
                  page: Landing(), context: context, segueToRoot: true);
            }
          });
        }
      });
    }
  }

  //Widgets
  Widget title({@required String title}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title ?? '',
        style: GoogleFonts.openSans(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
      ),
    );
  }
}
