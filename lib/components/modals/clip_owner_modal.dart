import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/user.dart';
import 'package:overlay_support/overlay_support.dart';

void showClipOwnerModal(
    {@required context,
    @required Function callback,
    @required String videoUid}) {
  //Functions
  Future<void> deleteClip() async {
    Navigator.pop(context);
    //Variables
    final batch = Firestore.instance.batch();
    final String uid = await User().getUid();

    batch.delete(Firestore.instance
        .collection('users')
        .document(uid)
        .collection('clips')
        .document(videoUid));

    batch.delete(Firestore.instance.collection('clips').document(videoUid));

    batch.commit().then((value) {
      showOverlayNotification((context) {
        return SuccessToast(
          title: 'Clip deleted',
        );
      });
      callback();
    });
  }

  //Modal
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: metaLightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  right: DeviceSize().getWidth(context) * 0.02,
                  left: DeviceSize().getWidth(context) * 0.02,
                  top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          deleteClip();
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    EvaIcons.trash2Outline,
                                    color: metaRed,
                                  ),
                                ),
                                Text(
                                  'Delete clip',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
