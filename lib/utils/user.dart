import 'package:firebase_auth/firebase_auth.dart';

class User {
  Future<String> getUid() async {
    // final openBox = await Hive.openBox('profile');
    // print(openBox.get('userUid'));

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    return uid;
  }
}
