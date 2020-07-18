import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/root/find_friends/find_friends.dart';
import 'package:meta_app/root/home/home.dart';
import 'package:meta_app/root/messages/messages.dart';
import 'package:meta_app/root/notifications/notifications.dart';
import 'package:meta_app/root/profile/profile.dart';
import 'package:meta_app/utils/colors.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  //PageController
  PageController pageController;
  int pageIndex = 0;

  //Variables
  Color messagesColor = Colors.grey;
  Color findFriendsColor = Colors.grey;
  Color homeColor;
  Color notificationsColor = Colors.grey;
  Color profileColor = Colors.grey;

  @override
  void initState() {
    //PageController
    pageController = PageController(initialPage: 2);
    super.initState();
  }

  @override
  void dispose() {
    //PageController
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: metaDarkBlue,
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Messages(),
            FindFriends(),
            Home(),
            Notifications(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 20,
          color: metaLightBlue,
          child: Container(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(0);
                      changeColor(tabIndex: 0);
                    },
                    icon: Icon(
                      EvaIcons.messageSquare,
                      color: messagesColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(1);
                      changeColor(tabIndex: 1);
                    },
                    icon: Icon(
                      EvaIcons.people,
                      color: findFriendsColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(2);
                      changeColor(tabIndex: 2);
                    },
                    iconSize: 45,
                    icon: Image.asset(
                      'images/meta_logo.png',
                      color: homeColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(3);
                      changeColor(tabIndex: 3);
                    },
                    icon: Icon(
                      EvaIcons.bell,
                      color: notificationsColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.jumpToPage(4);
                      changeColor(tabIndex: 4);
                    },
                    icon: Icon(
                      EvaIcons.person,
                      color: profileColor,
                    ),
                  ),
                ]),
          ),
        ));
  }

  onPageChanged({@required int pageIndex}) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  changeColor({@required int tabIndex}) {
    resetColors();

    //Change tab color
    if (tabIndex == 0) {
      setState(() {
        messagesColor = Colors.white;
      });
    } else if (tabIndex == 1) {
      setState(() {
        findFriendsColor = Colors.white;
      });
    } else if (tabIndex == 2) {
      setState(() {
        homeColor = null;
      });
    } else if (tabIndex == 3) {
      setState(() {
        notificationsColor = Colors.white;
      });
    } else if (tabIndex == 4) {
      setState(() {
        profileColor = Colors.white;
      });
    }
  }

  resetColors() {
    messagesColor = Colors.grey;
    findFriendsColor = Colors.grey;
    homeColor = Colors.grey;
    notificationsColor = Colors.grey;
    profileColor = Colors.grey;
  }
}
