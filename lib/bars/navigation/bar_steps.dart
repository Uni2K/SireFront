import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class BarSteps extends StatelessWidget {
  Color activated = navigationBarBackgroundColor;
  Color deactivated = Colors.grey.shade300;

  Color activatedText = Colors.white;
  Color deactivatedText = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ViewModelMain viewModelMain = Get.put(ViewModelMain());
      EditorSteps progress = viewModelMain.currentEditorStep.value;
      return Container(
          height:
              (MediaQuery.of(context).size.height * (1 - heightPercentage)) / 2,
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getStep(EditorSteps.Template, progress),
              getLine(),
              getStep(EditorSteps.Data, progress),
              getLine(),
              getStep(EditorSteps.Result, progress)
            ],
          )));
    });
  }

  Widget getStep(EditorSteps number, EditorSteps progress) {
    bool inProgress = progress == number;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getNumber(number, progress),
        Text(getText(number),
            style: TextStyle(
                fontSize: 13, color: inProgress ? activated : deactivatedText))
      ],
    );
  }

  Widget getNumber(EditorSteps number, EditorSteps progress) {
    bool isFinished = false;
    if (number == EditorSteps.Template && progress != EditorSteps.Template)
      isFinished = true;
    if (number == EditorSteps.Data && progress == EditorSteps.Result)
      isFinished = true;

    int numberInt=1;
    switch(number){
      case EditorSteps.Template: numberInt=1; break;
      case EditorSteps.Data: numberInt=2; break;
      case EditorSteps.Result: numberInt=3; break;

    }

    bool inProgress = progress == number;

    return MaterialButton(
      onPressed: stepAllowed(number)?() => navigate(number):null,
      minWidth: 0,
      height: 30,
      elevation: 0,
      color: isFinished ? activated : deactivated,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledColor:  deactivated,
      focusElevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      //fillColor: Colors.white,
      child: Text(
        numberInt.toString(),
        style: TextStyle(
            fontSize: 13,
            color: isFinished
                ? activatedText
                : (inProgress ? activated : deactivatedText)),
      ),
      padding: EdgeInsets.all(15),
      shape: CircleBorder(),
    );
  }

  Widget getLine() {
    return Container(
      margin: EdgeInsets.only(top: 19),
      height: 2,
      width: 70,
      color: navigationBarBackgroundColor.withAlpha(30),
    );
  }

  String getText(EditorSteps number) {
    switch (number) {
      case EditorSteps.Template:
        return "Vorlage";
      case EditorSteps.Data:
        return "Daten";
      case EditorSteps.Result:
        return "Fertig";
      default:
        return "";
    }
  }

  navigate(EditorSteps to) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.currentEditorStep.value=to;



  }

 bool stepAllowed(EditorSteps to) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    switch (to) {
      case EditorSteps.Template:
        return true;
      case EditorSteps.Data:
        return (viewModelMain.body!=null && viewModelMain.footer!=null && viewModelMain.header!=null);
      case EditorSteps.Result:
        return false;
      default:
        return false;
    }


  }
}
