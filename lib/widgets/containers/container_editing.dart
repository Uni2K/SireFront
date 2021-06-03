import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/buttons/button_download.dart';
import 'package:sire/widgets/dialogs/dialog_line.dart';
import 'package:sire/widgets/dialogs/dialog_signature.dart';
import 'package:sire/widgets/tiles/list_tile_editor.dart';

class ContainerEditing extends StatelessWidget {
  ContainerEditing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewModelMain vm = Get.put(ViewModelMain());
    return Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: 0.65,
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
                                    onClick: () => {resetAll()},
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
                          List<Widget> listitems = getEditorListItems();

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
                                onClick: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogLine(onFinish: (data) {
                                        if (data != null)
                                          vm.signatures.add(data);

                                        Navigator.of(context).pop();
                                      });
                                    },
                                  )
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonDefaultLight(
                                text: "Signaturen",
                                icon: FontAwesomeIcons.signature,
                                onClick: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogSignature(onFinish: (data) {
                                        if (data != null)
                                          vm.signatures.add(data);

                                        Navigator.of(context).pop();
                                      });
                                    },
                                  );
                                },
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
                                          FocusScope.of(context).unfocus();

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

  List<Widget> getEditorListItems() {
    List<Widget> widgets = List.empty(growable: true);
    ViewModelMain vm = Get.put(ViewModelMain());
    for (TileContent tile in vm.editorTiles) {
      widgets.add(ListTileEditor(contentType: tile));
    }

    return widgets;
  }

  resetAll() {
    ViewModelMain vm = Get.put(ViewModelMain());
    vm.signatures.clear();
    vm.currentHeader.value = 0;
    vm.resetTrigger.toggle();
  }
}
