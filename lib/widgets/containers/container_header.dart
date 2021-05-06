import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/utils/util_server.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';
import 'package:sire/widgets/misc/arrow_small.dart';
import 'package:sire/widgets/page/page_header.dart';

class ContainerHeader extends StatefulWidget {
  ContainerHeader({Key? key}) : super(key: key);

  @override
  _ContainerHeaderState createState() => _ContainerHeaderState();
}

class _ContainerHeaderState extends State<ContainerHeader> {
  ViewModelMain viewModelMain = Get.put(ViewModelMain());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonDefaultLight(
                  icon: Icons.done,
                  text: "Fertig",
                  onClick: () {
                    viewModelMain.currentContainer.value=ShowingContainer.EditingTool;
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(child:Center(child:Text(
                  "Wählen Sie einen passenden Headerbereich aus:",
                  style: TextStyle(
                      fontSize: 20, color: navigationBarBackgroundColor),
                ))),SizedBox(width: 10,),
                ArrowSmall()
              ],
            )),
        Expanded(
            child: ListSnappableCombined(
          onFocused: (int) {

          },
          contentPages: viewModelMain.headerCached
              .map((e) => PageHeader(
                    isDisable: true,
                    content: e,
                  ))
              .cast<PageHeader>()
              .toList(),
        ))
      ],
    );
  }
}
