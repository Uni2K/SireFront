import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/helper/typwriter_logo.dart';

class LogoSire extends StatefulWidget {
  LogoSire({Key? key}) : super(key: key);

  @override
  _LogoSireState createState() => _LogoSireState();
}

class _LogoSireState extends State<LogoSire> {
  bool start = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      start = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return !start? Container(): IntrinsicWidth(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: 'Berkshire',
            color: navigationBarBackgroundColor,
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedTextLogo(
                'Sire',
                cursor: "I",
                fontSize: 50,
                speed: Duration(milliseconds: 200),
              ),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ));
  }
}
