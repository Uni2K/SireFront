import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/misc/interactive_viewer_adjusted.dart';
import 'package:sire/widgets/misc/interactive_viewer_adjusted.dart'
as TrafoController;

class ButtonScale extends StatefulWidget {
  ButtonScale({Key? key}) : super(key: key);

  @override
  _ButtonScaleState createState() => _ButtonScaleState();
}

class _ButtonScaleState extends State<ButtonScale> {
  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain=Get.put(ViewModelMain());
  /*  viewModelMain.interactivePageKey?.currentState?.transformationController?.addListener(() {
      viewModelMain.interactivePageKey?.currentState?.transformationController?.value.getMaxScaleOnAxis();
    });*/


    return MaterialButton(
      onPressed: () {
      viewModelMain.interactivePageKey?.currentState?.animateScaleTo(1);
      },
      minWidth: 0,
      elevation: 0.0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color:  buttonBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.zoom_in_rounded,color: buttonTextColor, size: 18,),
          SizedBox(
            width: 5,
          ),
          Text("120%", style: TextStyle(color: buttonTextColor),)
        ],
      ),
    );
  }
}
