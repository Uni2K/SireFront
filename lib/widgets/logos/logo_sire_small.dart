import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/helper/typwriter_logo.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class LogoSireSmall extends StatelessWidget {
  LogoSireSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
            child: IntrinsicWidth(
                child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Berkshire',
            color: primaryColor,
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
              ViewModelMain viewModelMain = Get.put(ViewModelMain());
              viewModelMain.currentContainer.value = ShowingContainer.Welcome;
            },
          ),
        ))));
  }
}
