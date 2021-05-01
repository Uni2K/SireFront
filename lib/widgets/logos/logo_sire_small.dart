import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/helper/typwriter_logo.dart';

class LogoSireSmall extends StatefulWidget {
  LogoSireSmall({Key? key}) : super(key: key);

  @override
  _LogoSireState createState() => _LogoSireState();
}

class _LogoSireState extends State<LogoSireSmall> {


  @override
  Widget build(BuildContext context) {
    return Container(
        child: IntrinsicWidth(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Berkshire',
                color: navigationBarBackgroundColor,
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedTextLogo(
                    'Sire',
                    cursor: "I",
                    fontSize: 30,
                    speed: Duration(milliseconds: 0),
                  ),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            )));
  }
}
