import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/objects/dto_header.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/buttons/button_download.dart';
import 'package:sire/widgets/tiles/list_tile_editor.dart';

class ContainerEditing extends StatelessWidget {
  ContainerEditing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewModelMain vm = Get.put(ViewModelMain());

    return Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IntrinsicHeight(
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: buttonBackgroundColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ButtonDefaultLight(
                                    onClick: () {
                                      vm.currentContainer.value =
                                          ShowingContainer.HeaderSelection;
                                    },
                                    vertical: true,
                                    text: "Header",
                                    icon: FontAwesomeIcons.heading),
                                VerticalDivider(
                                  width: 0.5,
                                  thickness: 0.5,
                                ),
                                ButtonDefaultLight(
                                    onClick: () => null,
                                    vertical: true,
                                    text: "Schriftart",
                                    icon: FontAwesomeIcons.font),
                                VerticalDivider(
                                  width: 0.5,
                                  thickness: 0.5,
                                ),
                                ButtonDefaultLight(
                                    onClick: () => null,
                                    vertical: true,
                                    text: "Verwerfen",
                                    icon: FontAwesomeIcons.undo),
                                Divider(
                                  color: buttonTextColor,
                                )
                              ],
                            )))),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          color: buttonBackgroundColor,
                        ),
                        child: Obx(() {
                          List<Widget> listitems =
                              getEditorListItems(vm.currentHeader.value);
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return listitems[index];
                            },
                            itemCount: listitems.length,
                          );
                        }))),
                Flexible(
                  flex: 0,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: buttonBackgroundColor,
                      ),
                      child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ButtonDefaultLight(
                                text: "Zeile für Unterschrift",
                                icon: FontAwesomeIcons.textWidth,
                                onClick: () => null,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonDefaultLight(
                                text: "Handgeschriebene Signatur",
                                icon: FontAwesomeIcons.signature,
                                onClick: () => null,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ButtonDefaultLight(
                                text: "Bild hochladen",
                                icon: FontAwesomeIcons.fileUpload,
                                onClick: () => null,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: ButtonDownload(
                                        text: "Fertigstellen",
                                        icon: FontAwesomeIcons.filePdf,
                                        onClick: () {
                                          ViewModelMain viewModelMain =
                                              Get.put(ViewModelMain());
                                          viewModelMain.currentContainer.value =
                                              ShowingContainer.Final;
                                        },
                                      )))
                            ],
                          ))),
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> getEditorListItems(DTOHeader value) {
    List<Widget> widgets=List.empty(growable: true);

    widgets.add(ListTileEditor(contentType: TileContent.formatEmail));
    widgets.add(ListTileEditor(contentType: TileContent.addAddress));
    widgets.add(ListTileEditor(contentType: TileContent.addSignature));
    widgets.add(ListTileEditor(contentType: TileContent.spellCheck));






    return widgets;

  }
}
