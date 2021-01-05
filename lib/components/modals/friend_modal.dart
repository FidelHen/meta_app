import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/report_modal.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';

void showFriendModal({
  @required context,
}) {
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: metaLightBlue,
                      width: DeviceSize().getWidth(context),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showReportModal(
                              context: context,
                              reportType: ReportClaim.Account);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    EvaIcons.alertTriangle,
                                    color: metaYellow,
                                  ),
                                ),
                                Text(
                                  'Report account',
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
