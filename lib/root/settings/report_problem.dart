import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            right: DeviceSize().getWidth(context) / 10,
            left: DeviceSize().getWidth(context) / 10,
            top: 25),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
            child: Text(
              'Subject',
              style: textFeidTitleTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              focusNode: subjectNode,
              controller: subjectController,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (value) {
                messageNode.requestFocus();
              },
              maxLength: 50,
              textInputAction: TextInputAction.next,
              cursorColor: metaGreen,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaLightBlue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaGreen, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaRed, width: 2),
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Text(
              'Message',
              style: textFeidTitleTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              focusNode: messageNode,
              maxLines: 8,
              maxLength: 500,
              controller: messageController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: metaGreen,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaLightBlue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaGreen, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: metaRed, width: 2),
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: keyboardIsHidden
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: FloatingActionButton.extended(
                backgroundColor: metaGreen,
                onPressed: () {},
                label: Container(
                  width: DeviceSize().getWidth(context) * 0.7,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: fabButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
