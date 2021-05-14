import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/helper/typwriter_logo.dart';

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
    return Container(
        height: 100,
        child: !start? Container(height: 0,): IntrinsicWidth(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 60.0,
            fontFamily: 'Berkshire',
            color: primaryColor,
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedTextLogo(
                'Sire',
                cursor: "I",
                fontSize: 60,
                speed: Duration(milliseconds: 200),
              ),
            ],
            onTap: () {
            },
          ),
        )));
  }
}
