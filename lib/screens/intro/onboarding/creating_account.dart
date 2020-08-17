import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/screens/root.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';

class CreatingAccount extends StatefulWidget {
  //Constructor
  CreatingAccount(
      {@required this.bio,
      @required this.gamertags,
      @required this.profileImage,
      @required this.username});

  //Variables
  final String username;
  final String bio;
  final File profileImage;
  final List<GamertagModel> gamertags;

  @override
  _CreatingAccountState createState() => _CreatingAccountState();
}

class _CreatingAccountState extends State<CreatingAccount> {
  //Variables
  double iconSize;
  int step;
  String text;
  bool done;
  Widget icon;

  @override
  void initState() {
    //Variables
    setState(() {
      step = 1;
      done = false;
      updateText();
    });

    uploadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      body: SafeArea(
        child: !done
            ? Container(
                width: DeviceSize().getWidth(context),
                height: DeviceSize().getHeight(context),
                child: Column(
                  children: [
                    Container(
                      height: DeviceSize().getHeight(context) / 10,
                    ),
                    Container(
                      height: DeviceSize().getHeight(context) * 0.3,
                      child: FlareActor("flares/meta_incubator.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                          animation: "animate"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        text,
                        style: onboardingTitleTextStyle,
                      ),
                    )
                  ],
                ),
              )
            : Container(
                width: DeviceSize().getWidth(context),
                height: DeviceSize().getHeight(context),
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceSize().getHeight(context) / 5,
                    ),
                    Container(
                      width: DeviceSize().getHeight(context) * 0.15,
                      height: DeviceSize().getHeight(context) * 0.15,
                      child: ClipOval(
                        child: AnimatedContainer(
                          duration: Duration(seconds: 3),
                          width: DeviceSize().getHeight(context) * 0.15,
                          child: widget.profileImage != null
                              ? Image.file(
                                  widget.profileImage,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'images/temp_avatar.png',
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceSize().getHeight(context) / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        text,
                        style: onboardingTitleTextStyle,
                      ),
                    )
                  ],
                ),
              ),
      ),
      floatingActionButton: done
          ? extendedFAB(
              context: context,
              title: 'Continue',
              color: Colors.white,
              onPressed: () {
                Navigation()
                    .segue(page: Root(), context: context, fullScreen: true);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Functions
  Future<void> uploadData() async {
    //Variables
    String imageUrl;
    String uid = await User().getUid();

    //Firebase Storage
    if (widget.profileImage != null) {
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child('users/$uid/profile_image.jpg');
      final StorageUploadTask uploadTask =
          storageRef.putFile(widget.profileImage);
      final StorageTaskSnapshot completed = await uploadTask.onComplete;

      await completed.ref.getDownloadURL().then((url) {
        imageUrl = url;
      });
    }

    //Add some delaying
    await Future.delayed(Duration(seconds: 1));

    //Change UI
    setState(() {
      step = 2;
      updateText();
    });

    //Firestore
    final batch = Firestore.instance.batch();
    final firestorRef = Firestore.instance.collection('users').document(uid);

    batch.setData(
        firestorRef,
        {
          'username': widget.username,
          'bio': widget.bio,
          'profile_image': imageUrl ?? '',
          'is_registered': true
        },
        merge: true);

    widget.gamertags.forEach((element) {
      batch.setData(
          firestorRef.collection('gamertags').document(element.game.toString()),
          {
            'gamertag': element.gamertag,
            'game': element.game.toString(),
            'platform': element.platform.toString(),
          },
          merge: true);
    });

    batch.commit().then((_) async {
      await Future.delayed(Duration(seconds: 2));
      //Hive
      Hive.box('profile').put('is_registered', true);
      //Update statu
      setState(() {
        step = 3;
        done = true;
        updateText();
      });
    });
  }

  void updateText() {
    if (step == 1) {
      setState(() {
        text = 'Creating your profile';
      });
    } else if (step == 2) {
      setState(() {
        text = 'Running diagnostic';
      });
    } else if (step == 3) {
      setState(() {
        text = 'You\'re all set!';
      });
    }
  }
}
