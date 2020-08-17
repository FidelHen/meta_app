import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class Service {
  bool emailValidator({@required String email}) {
    return validator.email(email);
  }

  bool usernameValidator({@required String username}) {
    final alphanumeric = RegExp(r'^\S[a-zA-Z0-9_]{3,25}$');
    return alphanumeric.hasMatch(username.trim());
  }

  bool urlValidator({@required String url}) {
    return validator.url(url);
  }

  bool passwordValidator({@required String password}) {
    //Conditionals
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}
