import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/page/headers/header_prototype.dart';

import 'headers/header1.dart';
import 'headers/header2.dart';
import 'page_body.dart';
import 'page_header.dart';

class PagePrototype extends StatefulWidget {
  PagePrototype({Key? key}) : super(key: key);

  @override
  PagePrototypeState createState() => PagePrototypeState();
}

class PagePrototypeState extends State<PagePrototype>
    with SingleTickerProviderStateMixin {
  Rx<Color> _colorHeader = Colors.white.obs;
  Rx<Color> _colorBody = Colors.white.obs;
  late AnimationController _controller;
  final int milliSecondDuration = 500;
  final GlobalKey<PageHeaderState> pageHeaderKey = GlobalKey();

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    end: BoxDecoration(
      color: Colors.white,

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          spreadRadius: 20,
          blurRadius: 40,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      // No shadow.
    ),
  );

  @override
  initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    return /* DecoratedBoxTransition(

        position: DecorationPosition.background,
        decoration: decorationTween.animate(_controller),
        child:*/
        Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                spreadRadius: 20,
                blurRadius: 40,
                offset: Offset(0, 3), // changes position of shadow
              )
            ]),
            child: AspectRatio(
                aspectRatio: 1 / sqrt(2),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          // flex: (headerPercentage * 10).round(),
                          fit: FlexFit.loose,
                          child: Obx(() {

                            return PageHeader(
                              key: pageHeaderKey,
                              content: getHeader(viewModelMain.currentHeader.value),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                            //   flex: ((1 - headerPercentage) * 10).round(),
                            fit: FlexFit.loose,
                            child: Obx(() => Container(
                                  child: PageBody(),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: _colorBody.value,
                                          width: 6,
                                          style: BorderStyle.solid)),
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
    }
  }

  EdgeInsets getPadding() {
    double width = UtilSize.getPageWidth(context);

    double paddingTLR = paperMarginTLRRelative * width;
    double paddingB = paperMarginBRelative * width;
    return EdgeInsets.only(
        left: paddingTLR, right: paddingTLR, top: paddingTLR, bottom: paddingB);
  }

  void changeHeaderContent(String type, Map<String, String> text) {
    if (text.isBlank ?? false) return;
    pageHeaderKey.currentState?.changeHeaderContent(type, text);
  }

 HeaderPrototype getHeader(int value) {
    if(value==0)return Header1();
    if(value==1)return Header2();

    return Header1();

  }
}
