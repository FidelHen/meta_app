import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/screens/intro/landing.dart';
import 'package:meta_app/screens/intro/onboarding/gamertags.dart';
import 'package:meta_app/screens/root.dart';
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
        final openBox = await Hive.openBox('profile');
        openBox.put('userUid', userUid);

        stopLoading();

        //Navigate to onboarding
        Navigation().segueToRoot(
            page: Gamertags(), context: context, fullScreen: false);
      });
    })
        //Errors
        .catchError((error) {
      errorCodes(context: context, error: error);
      stopLoading();
    });
  }

  login(
      {@required BuildContext context,
      @required String email,
      @required String password,
      @required Function stopLoading}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email ?? '', password: password ?? '')
        .then((_) {
      Navigation()
          .segueToRoot(page: Root(), context: context, fullScreen: true);
    }).catchError((error) {
      errorCodes(context: context, error: error);
      stopLoading();
    });
  }

  signOut({@required BuildContext context}) {
    FirebaseAuth.instance.signOut().whenComplete(() {
      Navigation()
          .segueToRoot(page: Landing(), context: context, fullScreen: true);
    }).catchError((_) {
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Something went wrong, try again',
        );
      });
    });
  }

  resetPassword({@required BuildContext context, @required String email}) {
    showOkAlertDialog(
      context: context,
      title: 'Reset password',
      message: 'An email will be sent out to you shortly! Thank you',
    );
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  errorCodes({@required BuildContext context, @required error}) {
    if (error is PlatformException) {
      if (error.code == 'ERROR_USER_DISABLED') {
        showOkAlertDialog(
          context: context,
          title: 'Account disabled',
          message:
              'Your account has been disabled, email us at metatheapp@gmail.com if you have questions',
        );
      } else if (error.code == 'ERROR_USER_NOT_FOUND') {
        showOkAlertDialog(
          context: context,
          title: 'Account not found',
          message:
              'Your account cannot be found, please make sure all information is correct',
        );
      } else if (error.code == 'ERROR_WRONG_PASSWORD') {
        showOkAlertDialog(
          context: context,
          title: 'Cannot sign in',
          message:
              'Your email or password is wrong, please make sure all information is correct',
        );
      } else if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showOkAlertDialog(
          context: context,
          title: 'Cannot create account',
          message:
              'The email you provided is already in use, please provide a different one or login',
        );
      }
    } else {
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Something went wrong, try again',
        );
      });
    }
  }
}
