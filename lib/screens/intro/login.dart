import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/loading_progress_indicator.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/screens/intro/forgot_password.dart';
import 'package:meta_app/utils/auth.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/service.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //TextFields
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode emailNode;
  FocusNode passwordNode;

  //Variables
  bool keyboardIsHidden;
  bool isLoading;

  @override
  void initState() {
    //TextFields
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();

    //Variables
    isLoading = false;

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
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: LoadingProgressIndicator(),
      child: GestureDetector(
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
                EvaIcons.chevronDown,
                color: Colors.white,
                size: 40,
              ),
            ),
            backgroundColor: metaDarkBlue,
            title: Text(
              'We missed you',
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
                    contentPadding: textFieldContentPadding,
                  ),
                ),
              ),
              textFieldTitle(title: 'Password'),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  obscureText: true,
                  focusNode: passwordNode,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigation().segue(
                        page: ForgotPassword(),
                        context: context,
                        fullScreen: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 12),
                    child: Text(
                      'Forgot password',
                      style: smallButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          floatingActionButton: keyboardIsHidden
              ? extendedFAB(
                  color: Colors.white,
                  context: context,
                  title: 'Login',
                  tag: 'reset',
                  onPressed: () {
                    login();
                  })
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  //Functions
  void login() {
    //Variables
    String email = emailController.text ?? '';
    String password = passwordController.text ?? '';
    //Conditionals
    if (Service().emailValidator(email: email)) {
      if (Service().passwordValidator(password: password)) {
        //Success
        setState(() {
          isLoading = true;
        });

        Auth().login(
            email: emailController.text,
            password: password,
            context: context,
            stopLoading: stopLoading);
      } else {
        //Wrong password
        showOverlayNotification((context) {
          return ErrorToast(
            title: 'Enter a valid password',
          );
        });
      }
    } else {
      //Wrong email
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Enter a valid email',
        );
      });
    }
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
