import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_server.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';
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
    return Container(
        child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50, child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: navigationBarBackgroundColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Wählen Sie einen passenden Headerbereich aus:",
                      style: TextStyle(
                          fontSize: 20, color: navigationBarBackgroundColor),
                    )
                  ],
                )),

                Expanded(
                    child: ListSnappableCombined(
                  onFocused: (int) {
                    viewModelMain.currentHeader.value =
                        viewModelMain.headerCached.elementAt(int);
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
            )));
  }
}
