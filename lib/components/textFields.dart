import 'package:flutter/material.dart';
import 'package:meta_app/utils/text_style.dart';

//TextField title
Widget textFieldTitle({@required String title}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
    child: Text(
      title ?? '',
      style: textFeidTitleTextStyle,
    ),
  );
}

//TextField content padding
EdgeInsets textFieldContentPadding = EdgeInsets.fromLTRB(12, 18, 12, 18);
