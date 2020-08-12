import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

void showMessageModal({@required context, bool isNewMessage}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: DeviceSize().getHeight(context) * .9,
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
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: smallButtonTextStyle,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  showOverlayNotification((context) {
                                    return SuccessToast(
                                      title: 'Message sent',
                                    );
                                  });
                                  Navigator.pop(context);
                                  if (isNewMessage) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Send',
                                  style: smallButtonTextStyle.copyWith(
                                      color: metaGreen),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(22, 12, 22, 12),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'To: ',
                                          style: GoogleFonts.openSans(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        constraints:
                                            BoxConstraints(minWidth: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
                                          child: Center(
                                            child: Text(
                                              'RedDot224',
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(22, 12, 22, 12),
                                    child: TextField(
                                      maxLines: 6,
                                      autofocus: true,
                                      onSubmitted: (value) {},
                                      textInputAction: TextInputAction.done,
                                      cursorColor: metaGreen,
                                      style: textFieldTextStyle,
                                      decoration: InputDecoration(
                                        hintText: 'Message...',
                                        hintStyle: textFeidTitleTextStyle
                                            .copyWith(color: Colors.white24),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white10, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: metaGreen, width: 2),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: metaRed, width: 2),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 18, 12, 18),
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
