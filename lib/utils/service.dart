import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Service {
  bool emailValidator({@required String email}) {
    return EmailValidator.validate(email);
  }

  bool usernameValidator({@required String username}) {
    return true;
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
