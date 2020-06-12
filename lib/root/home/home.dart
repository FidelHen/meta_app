import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/root/home/search.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //TabController
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        bottom: TabBar(
          controller: tabController,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2, color: metaGreen)),
          tabs: [
            Tab(
              icon: Container(
                height: 22,
                child: Image.asset(
                  'images/league_logo.png',
                ),
              ),
            ),
            Tab(
              icon: Container(
                height: 34,
                child: Image.asset(
                  'images/cod_mw_logo.png',
                ),
              ),
            ),
            Tab(
              icon: Container(
                height: 22,
                child: Image.asset(
                  'images/fortnite_logo.png',
                ),
              ),
            ),
          ],
        ),
        title: Text(
          'Home',
          style: appBarTextStyle,
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Shimmer.fromColors(
                baseColor: metaYellow,
                highlightColor: metaRed,
                child: Icon(EvaIcons.globe2Outline)),
            onPressed: () {},
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(EvaIcons.search),
              onPressed: () {
                Navigation()
                    .segue(page: Search(), context: context, fullScreen: false);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
