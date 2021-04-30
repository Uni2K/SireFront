import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/always_showing_thumb.dart';
import 'package:sire/helper/even_rounded_rect_slider_track_shape.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class ScrollbarTranslation extends StatefulWidget {
  ScrollbarTranslation({Key? key}) : super(key: key);

  @override
  _ScrollbarTranslationState createState() => _ScrollbarTranslationState();
}

double? currentScale = 1;
double? currentHeight = 1;

class _ScrollbarTranslationState extends State<ScrollbarTranslation> {
  double _value = 0.5;

  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
late ScrollController scrollController;


  @override
  void initState() {
    super.initState();
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.interactivePageKey?.currentState?.controller.addListener(() {
      currentScale = viewModelMain
          .interactivePageKey?.currentState?.controller.value
          .getMaxScaleOnAxis();
      calculateScrollbarHeight();
      scrollController.animateTo(30, duration:Duration(milliseconds: 30), curve: Curves.ease);
      setState(() {});
    });

    //scrollController=ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    return IntrinsicWidth(
        child: RotatedBox(
            quarterTurns: 1,
            child:Scrollbar(child: Container(height: 20,width: 50,color: Colors.red,), controller: scrollController,) ));
  }

  ///the thumb is the height of the website/viewport and the total height is the page
  void calculateScrollbarHeight() {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    double widthViewer = MediaQuery.of(context).size.width * 0.6;
    double heightViewer = MediaQuery.of(context).size.height;
    double widthPage = min(
        MediaQuery.of(context).size.height * heightPercentage,
        widthViewer * 0.9);
    double heightPage = widthPage * sqrt(2) * currentScale!;

    double scrollbarheight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.height / 5) -
        35;

    double limit = MediaQuery.of(context).size.height / 5 * (pow(currentScale!, 3));
    heightPage+=2*limit; //add the limits
    double percentage=(heightViewer/heightPage);
    currentHeight =percentage*scrollbarheight;
   // print("p: $percentage   c $currentHeight   sc $scrollbarheight");



  }
}

