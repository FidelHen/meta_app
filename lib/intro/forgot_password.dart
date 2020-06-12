import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //Textfields
  TextEditingController emailController;
  FocusNode emailNode;

  @override
  void initState() {
    //Textfields
    emailController = TextEditingController();
    emailNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    //Textfields
    emailController.dispose();
    emailNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
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
          title: Text(
            'Forgot password',
            style: appBarTextStyle,
          ),
        ),
        backgroundColor: metaDarkBlue,
        body: Padding(
          padding: EdgeInsets.only(
              right: DeviceSize().getWidth(context) / 10,
              left: DeviceSize().getWidth(context) / 10,
              top: 25),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: Text(
                  'Email',
                  style: textFeidTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  autofocus: true,
                  focusNode: emailNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onSubmitted: (value) {},
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
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
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: () {},
            label: Container(
              width: DeviceSize().getWidth(context) * 0.7,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: Center(
                    child: Text(
                      'Reset',
                      style: fabButtonTextStyle,
                    ),
                  )),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
