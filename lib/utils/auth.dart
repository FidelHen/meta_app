import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/screens/intro/onboarding/gamertags.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:overlay_support/overlay_support.dart';

class Auth {
  createAccountWithEmail({
    @required String email,
    @required String password,
    @required BuildContext context,
    @required Function stopLoading,
  }) {
    //Create account
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        //Success
        .then((value) {
      //Variables
      final String userUid = value.user.uid;

      //Set Firestore data
      Firestore.instance.collection('users').document(userUid).setData({
        'uid': userUid,
        'email': email,
        'member_since': DateTime.now().millisecondsSinceEpoch,
        'is_registered': false,
      }).then((_) async {
        //Store data locally-
        final box = Hive.box('profile');
        box.put('userUid', userUid);

        stopLoading();

        //Navigate to onboarding
        Navigation().segueToRoot(
            page: Gamertags(), context: context, fullScreen: false);
      });
    })
        //Errors
        .catchError((error) {
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Something went wrong, try again',
        );
      });
      stopLoading();
    });
  }

  signOut() {}
}
