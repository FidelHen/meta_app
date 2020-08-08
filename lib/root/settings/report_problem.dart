import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class ReportProblem extends StatefulWidget {
  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  //TextFields
  TextEditingController subjectController;
  TextEditingController messageController;
  FocusNode subjectNode;
  FocusNode messageNode;

  //Variables
  bool keyboardIsHidden;

  @override
  void initState() {
    //TextFields
    subjectController = TextEditingController();
    messageController = TextEditingController();
    subjectNode = FocusNode();
    messageNode = FocusNode();

    //Keyboard
    keyboardIsHidden = true;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardIsHidden = !visible;
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    //Textfields
    subjectController.dispose();
    messageController.dispose();
    subjectNode.dispose();
    messageNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.chevronLeft,
            color: Colors.white,
            size: 40,
          ),
        ),
        backgroundColor: metaDarkBlue,
        elevation: 0,
        title: Text(
          'Report a problem',
          style: appBarTextStyle,
        ),
      ),
      backgroundColor: metaDarkBlue,
      body: Padding(
        padding: EdgeInsets.only(
            right: DeviceSize().getWidth(context) / 16,
            left: DeviceSize().getWidth(context) / 16,
            top: 25),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          textFieldTitle(title: 'Subject'),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              focusNode: subjectNode,
              controller: subjectController,
              onSubmitted: (value) {
                messageNode.requestFocus();
              },
              maxLength: 50,
              textInputAction: TextInputAction.next,
              cursorColor: metaGreen,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
          textFieldTitle(title: 'Message'),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              focusNode: messageNode,
              textInputAction: TextInputAction.done,
              maxLines: 8,
              maxLength: 500,
              controller: messageController,
              cursorColor: metaGreen,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: keyboardIsHidden
          ? extendedFAB(
              context: context,
              title: 'Submit',
              color: Colors.white,
              onPressed: () {
                showOverlayNotification((context) {
                  return SuccessToast(
                    title: 'Successfully sent',
                  );
                });
                Navigator.pop(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
