import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/lists/list_snappable_header.dart';
import 'package:sire/widgets/misc/arrow_small.dart';
import 'package:sire/widgets/page/headers/header1.dart';
import 'package:sire/widgets/page/headers/header2.dart';
import 'package:sire/widgets/page/page_header.dart';

class ContainerHeader extends StatelessWidget {
  ContainerHeader({Key? key}) : super(key: key);

  final ViewModelMain viewModelMain = Get.put(ViewModelMain());

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
                  icon: FontAwesomeIcons.check,
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
                      fontSize: 20, color: primaryColor),
                ))),SizedBox(width: 10,),
                ArrowSmall()
              ],
            )),
        Expanded(
            child: ListSnappableHeader(
          onFocused: (int) {

          },
          contentPages: getHeaders()
        ))
      ],
    );
  }

  List<PageHeader> getHeaders(){
    List<PageHeader> pageHeaders=List.empty(growable: true);
    pageHeaders.add(PageHeader(content: Header1(readOnly: true,),key: GlobalKey(),));
    pageHeaders.add(PageHeader(content: Header2(readOnly: true),key: GlobalKey()));
    pageHeaders.add(PageHeader(content: Header1(readOnly: true,),key: GlobalKey()));
    pageHeaders.add(PageHeader(content: Header2(readOnly: true),key: GlobalKey()));
    pageHeaders.add(PageHeader(content: Header1(readOnly: true,),key: GlobalKey()));
    pageHeaders.add(PageHeader(content: Header2(readOnly: true),key: GlobalKey()));
    return pageHeaders;
  }
}
