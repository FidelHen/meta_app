import 'package:easy_web_view/easy_web_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/link_modal.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';

class WebView extends StatelessWidget {
  WebView({@required this.title, @required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          title,
          style: appBarTextStyle,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(EvaIcons.moreHorizotnal),
              onPressed: () {
                showLinkModal(context: context);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: EasyWebView(src: url, isHtml: false, onLoaded: () {}),
    );
  }
}
