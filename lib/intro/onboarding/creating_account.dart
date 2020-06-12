import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/root/root.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class CreatingAccount extends StatefulWidget {
  @override
  _CreatingAccountState createState() => _CreatingAccountState();
}

class _CreatingAccountState extends State<CreatingAccount>
    with TickerProviderStateMixin {
  //Variables
  double iconSize;
  int step;
  String text;
  bool done;
  AnimationController motionController;
  Animation motionAnimation;
  Widget icon;

  @override
  void initState() {
    //Variables
    step = 1;
    done = false;

    //Functions
    updateText();

    //Testing delays
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        step = 2;
        updateText();
      });
    });
    Future.delayed(Duration(seconds: 4)).then((_) {
      setState(() {
        step = 3;
        done = true;
        updateText();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //Functions
    pulseIcon();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, -0.3),
          child: Container(
            height: DeviceSize().getHeight(context) * 0.2 + 100,
            child: Column(
              children: [
                !done
                    ? Container(
                        height: iconSize,
                        child: Image.asset(
                          'images/loading_icon.png',
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 3),
                          height: DeviceSize().getHeight(context) * 0.15,
                          child: Image.asset(
                            'images/temp_avatar.png',
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                  child: Text(
                    text,
                    style: GoogleFonts.sourceCodePro(
                        color: Colors.white,
                        fontSize: 20,
                        wordSpacing: -2,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: done
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigation()
                      .segue(page: Root(), context: context, fullScreen: true);
                },
                label: Container(
                  width: DeviceSize().getWidth(context) * 0.7,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: fabButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void pulseIcon() {
    //Variables
    iconSize = DeviceSize().getHeight(context) * 0.2;

    //Pulse animation
    motionController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.9,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        iconSize = motionController.value * 200;
      });
    });
  }

  void updateText() {
    if (step == 1) {
      setState(() {
        text = 'Creating your profile';
      });
    } else if (step == 2) {
      setState(() {
        text = 'Running diagnostic';
      });
    } else if (step == 3) {
      setState(() {
        text = 'You\'re all set!';
      });
    }
  }
}
