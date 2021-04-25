import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_scale.dart';

import 'package:sire/widgets/interactive_page.dart';

class ScreenMain extends StatefulWidget {
  GlobalKey<InteractivePageState> pageKey = GlobalKey();

  ScreenMain({Key? key}) : super(key: key){
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.setInteractivePageKey(pageKey);
  }


  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractivePage(key: widget.pageKey,),
        Align(
          child: Container(margin: EdgeInsets.all(10), child: ButtonScale()),
          alignment: Alignment.bottomLeft,
        ),
      ],
    );
  }
}
