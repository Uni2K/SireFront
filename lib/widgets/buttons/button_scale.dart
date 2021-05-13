import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/always_showing_thumb.dart';
import 'package:sire/helper/even_rounded_rect_slider_track_shape.dart';
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
  double _value = 1;

  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    return IntrinsicHeight(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
      MaterialButton(
        focusNode: FocusNode(skipTraversal: true, descendantsAreFocusable: false),

        onPressed: () {
          disabled = true;
          _value = 1;
          setState(() {});

          viewModelMain.interactivePageKey?.currentState
              ?.resetPage()
              .whenComplete(() {
            disabled = false;
          });
        },
        minWidth: 0,
        elevation: 0.0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        color: buttonBackgroundColor,
        shape: CircleBorder(),

        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //fillColor: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.undo,
              color: buttonTextColor,
              size: 18,
            ),
          ],
        ),
      ),
      SizedBox(
        width: 10,
      ),
      SizedBox(
          width: 100,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: buttonBackgroundColor,
              inactiveTrackColor: buttonBackgroundColor,
              trackShape: EvenRoundedRectSliderTrackShape(),
              trackHeight: 5.0,
              showValueIndicator: ShowValueIndicator.never,
              thumbShape: AlwaysShowingThumb(enabledThumbRadius: 6.0),
              thumbColor: navigationBarBackgroundColor,
              overlayColor: navigationBarBackgroundColorLight,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              inactiveTickMarkColor: Colors.transparent,
              activeTickMarkColor: Colors.transparent,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: buttonBackgroundColor,
              valueIndicatorTextStyle: TextStyle(color: buttonTextColor),
            ),
            child: Slider(
              value: _value,
              min: minScale,
              focusNode: FocusNode(skipTraversal: true, descendantsAreFocusable: false),
              max: maxScale,
              label: '${(_value * 100).round()}%',
              divisions: ((maxScale - minScale) * 10).round(),
              onChangeStart: (s){
                viewModelMain.isCurrentlyTouched.value=true;
              },
              onChangeEnd: (s){
                viewModelMain.isCurrentlyTouched.value=false;

              },

              onChanged: (value) {
                if (disabled) return;
                double val = dp(value, 2);

                if (_value != val) {
                  viewModelMain.interactivePageKey?.currentState
                      ?.animateScaleTo(val);

                  setState(
                    () {
                      _value = val;
                    },
                  );
                }
              },
            ),
          ))
    ]));

    /*  viewModelMain.interactivePageKey?.currentState?.transformationController?.addListener(() {
      viewModelMain.interactivePageKey?.currentState?.transformationController?.value.getMaxScaleOnAxis();
    });*/

    /*

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
    )*/
    ;
  }
}
