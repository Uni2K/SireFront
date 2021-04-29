import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_go.dart';
import 'package:sire/widgets/buttons/button_scale.dart';

import 'package:sire/widgets/interactive_page.dart';
import 'package:sire/widgets/logos/logo_createdby.dart';
import 'package:sire/widgets/logos/logo_sire.dart';
import 'package:sire/widgets/overlay/scrollbar_translation.dart';
import 'package:sire/widgets/overlay/switcher_darkmode.dart';

class ScreenMain extends StatefulWidget {
  GlobalKey<InteractivePageState> pageKey = GlobalKey();

  ScreenMain({Key? key}) : super(key: key) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.setInteractivePageKey(pageKey);
  }

  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        InteractivePage(
          key: widget.pageKey,
        ),
        Align(
          child: Container(margin: EdgeInsets.all(10), child: ButtonScale()),
          alignment: Alignment.bottomLeft,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 5,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 5 -
              15,
          width: (1 - viewerWidth - 0.1) * MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoSire(),
              SizedBox(
                height: 100,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Erstellen Sie jetzt Ihr:",
                      style: TextStyle(fontSize: 20, color: buttonTextColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Notiz Anschreiben Kündigung Bewerbungsschreiben",
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 30, color: navigationBarBackgroundColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
              ButtonGo(
                onClick: () {},
                text: "Los gehts",
              ),
              Spacer(),
              LogoCreatedby()
            ],
          ),
          left: viewerWidth * MediaQuery.of(context).size.width,
        ),
        Align(
            child: Container(
                margin: EdgeInsets.all(10), child: SwitcherDarkmode()),
            alignment: Alignment.topRight)
      ],
    ));
  }
}
