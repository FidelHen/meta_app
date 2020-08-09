import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //TextFields
  TextEditingController oldPasswordController;
  TextEditingController passwordController;
  FocusNode oldPasswordNode;
  FocusNode passwordNode;

  //Keyboard
  bool keyboardIsHidden;

  //Variables
  bool isPasswordVisible;
  Icon currentPasswordIcon;

  @override
  void initState() {
    //TextFields
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    oldPasswordNode = FocusNode();
    passwordNode = FocusNode();

    //Variables
    isPasswordVisible = false;
    currentPasswordIcon = Icon(
      EvaIcons.eyeOutline,
      color: Colors.white,
    );

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
    oldPasswordController.dispose();
    passwordController.dispose();
    oldPasswordNode.dispose();
    passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: metaDarkBlue,
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
        title: Text(
          'Change password',
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
          textFieldTitle(title: 'Current password'),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              obscureText: true,
              focusNode: oldPasswordNode,
              controller: oldPasswordController,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (value) {
                passwordNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
              cursorColor: metaGreen,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
          textFieldTitle(title: 'Password'),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              obscureText: !isPasswordVisible,
              focusNode: passwordNode,
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: metaGreen,
              textInputAction: TextInputAction.done,
              style: textFieldTextStyle,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: passwordAction,
                  child: currentPasswordIcon,
                ),
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Password must be minimum 8 characters',
              style: textFieldDescriptionTextStyle,
            ),
          ),
        ]),
      ),
      floatingActionButton: keyboardIsHidden
          ? extendedFAB(
              context: context,
              title: 'Reset',
              color: Colors.white,
              onPressed: () {
                showOverlayNotification((context) {
                  return SuccessToast(
                    title: 'Successfully reset',
                  );
                });
                Navigator.pop(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Functions
  void passwordAction() {
    if (isPasswordVisible) {
      currentPasswordIcon = Icon(
        EvaIcons.eyeOutline,
        color: Colors.white,
      );
    } else {
      currentPasswordIcon = Icon(
        EvaIcons.eyeOff2,
        color: Colors.white,
      );
    }

    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
}
