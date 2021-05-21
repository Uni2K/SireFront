import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/helper/always_showing_thumb.dart';
import 'package:sire/widgets/helper/even_rounded_rect_slider_track_shape.dart';

class UtilWidgets  {

  static SliderThemeData getDefaultSliderTheme(BuildContext context){
    return SliderTheme.of(context).copyWith(
      activeTrackColor: buttonBackgroundColor,
      inactiveTrackColor: buttonBackgroundColor,
      trackShape: EvenRoundedRectSliderTrackShape(),
      trackHeight: 5.0,
      showValueIndicator: ShowValueIndicator.never,
      thumbShape: AlwaysShowingThumb(enabledThumbRadius: 6.0),
      thumbColor: primaryColor,
      overlayColor: primaryColorLight,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
      tickMarkShape: RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: buttonBackgroundColor,
      valueIndicatorTextStyle: TextStyle(color: buttonTextColor),
    );
  }


}
