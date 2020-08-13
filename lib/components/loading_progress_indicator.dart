import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: SpinKitDoubleBounce(
          size: 40,
          color: Colors.white,
        ));
  }
}
