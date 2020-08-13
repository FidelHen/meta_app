import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/utils/auth.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //Textfields
  TextEditingController emailController;
  FocusNode emailNode;

  //Variables
  bool keyboardIsHidden;

  @override
  void initState() {
    //Textfields
    emailController = TextEditingController();
    emailNode = FocusNode();

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
              right: DeviceSize().getWidth(context) / 16,
              left: DeviceSize().getWidth(context) / 16,
              top: 25),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              textFieldTitle(title: 'Email'),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  focusNode: emailNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onSubmitted: (value) {},
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    enabledBorder: keyboardEnabledBorder,
                    focusedBorder: keyboardFocusedBorder,
                    errorBorder: keyboardErrorBorder,
                    border: OutlineInputBorder(),
                    contentPadding: textFieldContentPadding,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: keyboardIsHidden
            ? extendedFAB(
                color: Colors.white,
                context: context,
                title: 'Reset',
                tag: 'resett',
                onPressed: () {
                  resetPassword();
                })
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  //Functions
  void resetPassword() {
    //Variables
    final email = emailController.text.trim();

    //Conditionals
    if (EmailValidator.validate(email)) {
      Auth().resetPassword(context: context, email: email);
    } else {
      //Wrong email
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Enter a valid email',
        );
      });
    }
  }
}
