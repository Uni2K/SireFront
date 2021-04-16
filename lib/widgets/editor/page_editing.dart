import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';

class PageEditing extends StatefulWidget {
  PageEditing({Key? key}) : super(key: key);

  @override
  PageEditingState createState() => PageEditingState();
}

class PageEditingState extends State<PageEditing> {
  Rx<Color> _colorHeader = Colors.white.obs;
  Rx<Color> _colorBody = Colors.white.obs;
  Rx<Color> _colorFooter = Colors.white.obs;

  int milliSecondDuration = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              spreadRadius: 20,
              blurRadius: 40,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: AspectRatio(
            aspectRatio: 1 / sqrt(2),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 20,
                        fit: FlexFit.tight,
                        child: Obx(() => AnimatedContainer(
                          decoration: BoxDecoration(
                              border: Border.all( color: _colorHeader.value, width: 6, style: BorderStyle.solid)
                          ),
                          onEnd: (){
                            if(_colorHeader.value!=Colors.white)
                            _colorHeader.value = Colors.white;
                          },
                              duration:
                                  Duration(milliseconds: milliSecondDuration),
                            ))),
                    Flexible(
                        flex: 70,
                        fit: FlexFit.tight,
                        child: Obx(() => AnimatedContainer(
                          decoration: BoxDecoration(
                            border: Border.all( color: _colorBody.value, width: 6, style: BorderStyle.solid)
                          ),
                          onEnd: (){
                            if(_colorBody.value!=Colors.white)
                            _colorBody.value = Colors.white;
                          },
                            duration:
                                Duration(milliseconds: milliSecondDuration),
                           ))),
                    Flexible(
                        flex: 10,
                        fit: FlexFit.tight,
                        child: Obx(() => AnimatedContainer(
                            decoration: BoxDecoration(
                                border: Border.all( color: _colorFooter.value, width: 6, style: BorderStyle.solid)
                            ),
                            onEnd: (){
                              if(_colorFooter.value!=Colors.white)
                                _colorFooter.value = Colors.white;
                            },
                            duration:
                                Duration(milliseconds: milliSecondDuration),
                            ))),
                  ],
                ))));
  }

  void highlightAnimation(int i) {
    switch (i) {
      case 0:
        _colorHeader.value = highlightColor;
        break;
      case 1:
        _colorBody.value = highlightColor;
        break;
      case 2:
        _colorFooter.value = highlightColor;
        break;
    }
  }
}
