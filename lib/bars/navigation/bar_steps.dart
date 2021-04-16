import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_color.dart';

class BarSteps extends StatelessWidget {
  Color activated = navigationBarBackgroundColor;
  Color deactivated = Colors.grey.shade300;

  Color activatedText = Colors.white;
  Color deactivatedText = Colors.black;

  int progress = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height*(1-heightPercentage))/2,
        child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        getStep(1),
        getLine(),
        getStep(2),
        getLine(),
        getStep(3)
      ],
    )));
  }


  Widget getStep(int number){
    bool isFinished = progress > number;
    bool inProgress = progress == number;
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
      getNumber(number),
      Text("Vorlage",  style: TextStyle(
          fontSize: 13, color: inProgress?activated:deactivatedText))
    ],);
  }

  Widget getNumber(int number) {
    bool isFinished = progress > number;
    bool inProgress = progress == number;

    return MaterialButton(
      onPressed: () => null,
      minWidth: 0,
      height: 30,
      elevation: 0,
      color: isFinished ? activated : deactivated,
      hoverElevation: 0,
      highlightElevation: 0,

      focusElevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      //fillColor: Colors.white,
      child: Text(
        number.toString(),
        style: TextStyle(
            fontSize: 13, color: isFinished ? activatedText : (inProgress?activated:deactivatedText)),
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
}
