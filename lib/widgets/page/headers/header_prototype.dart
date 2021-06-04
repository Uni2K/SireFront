import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/input/inputfield_quill.dart';

abstract class HeaderPrototype extends StatelessWidget {
  final bool readOnly;
  final List<InputfieldQuill> inputFields = List.empty(growable: true);

  HeaderPrototype({Key? key, required this.readOnly}) : super(key: key){

      ViewModelMain viewModelMain = Get.put(ViewModelMain());
      viewModelMain.resetTrigger.listen((p0) {
        for(InputfieldQuill field in inputFields){
          (field.key as GlobalKey<InputfieldQuillState>).currentState!.resetField();
        }
      });


  }

  void registerInputField(InputfieldQuill input) {
    inputFields.add(input);
  }

  void changeHeaderContent(String type, Map<String, String> text) {
    for (InputfieldQuill value in inputFields) {
      (value.key as GlobalKey<InputfieldQuillState>)
          .currentState
          ?.changeHeaderContent(type, text);
    }
  }

  EdgeInsets getPadding(BuildContext context) {
    double width = UtilSize.getPageWidth(context);
    double paddingTLR = paperMarginTLRRelative * width;
    return EdgeInsets.only(
        left: paddingTLR, right: paddingTLR, top: paddingTLR, bottom: 10);
  }

  EdgeInsets getMargin(BuildContext context) {
    return EdgeInsets.only(bottom:  readOnly?10:0);
  }
  InputfieldQuill createInputField(
      {TextStyle style = const TextStyle(fontWeight: FontWeight.normal),
      required String initialContent,
      String? contentDescription}) {
    InputfieldQuill inputfieldQuill = InputfieldQuill(
      key: GlobalKey<InputfieldQuillState>(),
      readOnly: readOnly,
      style: style,
      contentDescription: contentDescription,
      initialContent: initialContent,
    );
    inputFields.add(inputfieldQuill);
    return inputfieldQuill;
  }




  TextStyle getBoldTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  double getDefaultSpace() {
    return 10;
  }

  double getMiniIconSize() {
    return 12;
  }

  List<String> getContentChilds(String identifier) {

    List<String> childs=List.empty(growable: true);
    List<String?> contentDescriptionsList=inputFields.where((element) => element.contentDescription!=null && element.contentDescription!.contains(identifier)).map((e) => e.contentDescription).toList();
    for(String? contentDescriptionParent in contentDescriptionsList){
      if(contentDescriptionParent==null)continue;

      List<String> contentDescriptions = contentDescriptionParent.split(";");
      for (int i = 0; i < contentDescriptions.length; i++) {
        if (i == 0 && contentDescriptions[i] != identifier) {
         continue;
        } else if (i == 0) {
          continue;
        }
        String x=contentDescriptions[i];
        if(!childs.contains(x))
        childs.add(x);
      }
    }
    return childs;
  }




}
