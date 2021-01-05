import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/report_text_modal.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/user.dart';
import 'package:overlay_support/overlay_support.dart';

void showReportModal({@required context, @required ReportClaim reportType}) {
  //Functions
  void report({@required String reason, @required ReportClaim report}) async {
    showOverlayNotification((context) {
      return SuccessToast(
        title: 'Reported',
      );
    });
    Navigator.pop(context);

    //Variables
    final String uid = await User().getUid();

    //Upload data
    Firestore.instance.collection('reports').document().setData({
      'reporter_uid': uid,
      'reason': reason,
      'report_type': report.toString()
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
                          report(
                              reason: 'Bullying or harrassment',
                              report: reportType);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  'Bullying or harrassment',
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          report(reason: 'Scam or fraud', report: reportType);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  'Scam or fraud',
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          report(
                              reason: 'Nudity or sexual activity',
                              report: reportType);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  'Nudity or sexual activity',
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          report(
                              reason: 'Wrong content for Meta',
                              report: reportType);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  'Wrong content for Meta',
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showReportTextModal(context: context);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  'Other',
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
