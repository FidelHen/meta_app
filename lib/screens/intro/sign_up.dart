import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/screens/intro/onboarding/gamertags.dart';
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
  FocusNode emailNode;
  FocusNode passwordNode;

  //Keyboard
  bool keyboardIsHidden;

  //Variables
  bool isPasswordVisible;
  Icon currentPasswordIcon;

  @override
  void initState() {
    //TextFields
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
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
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();

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
            textFieldTitle(title: 'Email'),
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
                style: GoogleFonts.openSans(
                    color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          ]),
        ),
        floatingActionButton: keyboardIsHidden
            ? extendedFAB(
                color: Colors.white,
                context: context,
                title: 'Sign up',
                onPressed: () {
                  Navigation().segueToRoot(
                      page: Gamertags(), context: context, fullScreen: false);
                })
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
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
