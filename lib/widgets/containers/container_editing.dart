import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/buttons/button_download.dart';
import 'package:sire/widgets/lists/list_tile_editor.dart';

class ContainerEditing extends StatefulWidget {
  ContainerEditing({Key? key}) : super(key: key);

  @override
  _ContainerEditingState createState() => _ContainerEditingState();
}

class _ContainerEditingState extends State<ContainerEditing> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: buttonBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: buttonTextColor,
                  size: 18,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(30),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTileEditor(contentType: TileContent.formatEmail,);
                          },
                          itemCount: 20,
                        ))),
                Flexible(
                  flex: 0,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonDefaultLight(
                            text: "Zeile für Unterschrift",
                            icon: Icons.text_format_rounded,
                            onClick: () => null,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonDefaultLight(
                            text: "Handgeschriebene Signatur",
                            icon: Icons.short_text,
                            onClick: () => null,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          ButtonDefaultLight(
                            text: "Bild hochladen",
                            icon: Icons.image,
                            onClick: () => null,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(child: Align(alignment:Alignment.bottomRight,child:ButtonDownload(
                            text: "Fertigstellen",
                            icon: FontAwesomeIcons.filePdf,
                            onClick: () {
                              ViewModelMain viewModelMain = Get.put(ViewModelMain());
                              viewModelMain.currentContainer.value=ShowingContainer.Final;

                            },
                          )))
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
