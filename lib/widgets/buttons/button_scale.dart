import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/utils/util_widgets.dart';
import 'package:sire/widgets/helper/always_showing_thumb.dart';
import 'package:sire/widgets/helper/even_rounded_rect_slider_track_shape.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class ButtonScale extends StatefulWidget {
  ButtonScale({Key? key}) : super(key: key);

  @override
  _ButtonScaleState createState() => _ButtonScaleState();
}

class _ButtonScaleState extends State<ButtonScale> {
  double _value = 1;

  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    return IntrinsicHeight(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
      MaterialButton(
        focusNode:
            FocusNode(skipTraversal: true, descendantsAreFocusable: false),

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
            data: UtilWidgets.getDefaultSliderTheme(context),
            child: Slider(
              value: _value,
              min: minScale,
              focusNode: FocusNode(
                  skipTraversal: true, descendantsAreFocusable: false),
              max: maxScale,
              label: '${(_value * 100).round()}%',
              divisions: ((maxScale - minScale) * 10).round(),
              onChangeStart: (s) {
                viewModelMain.isCurrentlyTouched.value = true;
              },
              onChangeEnd: (s) {
                viewModelMain.isCurrentlyTouched.value = false;
              },
              onChanged: (value) {
                if (disabled) return;
                double val = UtilSize.dp(value, 2);

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
  }
}
