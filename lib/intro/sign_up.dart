import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/intro/onboarding/gamertags.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //TextFields
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  FocusNode emailNode;
  FocusNode passwordNode;
  FocusNode confirmPasswordNode;

  //Keyboard
  bool keyboardIsHidden;

  @override
  void initState() {
    //TextFields
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();

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
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            'Welcome aboard',
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
                focusNode: emailNode,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (value) {
                  passwordNode.requestFocus();
                },
                textInputAction: TextInputAction.next,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: Text(
                'Password',
                style: textFeidTitleTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                obscureText: true,
                focusNode: passwordNode,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: metaGreen,
                textInputAction: TextInputAction.next,
                onSubmitted: (password) {
                  confirmPasswordNode.requestFocus();
                },
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: Text(
                'Confirm password',
                style: textFeidTitleTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                obscureText: true,
                focusNode: confirmPasswordNode,
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
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
          ]),
        ),
        floatingActionButton: keyboardIsHidden
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigation().segueToRoot(
                        page: Gamertags(), context: context, fullScreen: false);
                  },
                  label: Container(
                    width: DeviceSize().getWidth(context) * 0.7,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: fabButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
