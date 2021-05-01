import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';

class InputfieldPage extends StatefulWidget {
  InputfieldPage({
    Key? key,
    required this.hint,
    required this.style,
    required this.onSubmitted,
    required this.focusNode, this.maxLines,
  }) : super(key: key);

  final String hint;
  final Style style;

  final int? maxLines;
  final VoidCallback onSubmitted;
  final FocusNode focusNode;

  TextEditingController textEditingController = new TextEditingController();

  @override
  _InputfieldPageState createState() => _InputfieldPageState();
}

//https://github.com/fluttercandies/extended_text
//https://github.com/flutter/flutter/issues/30688
class _InputfieldPageState extends State<InputfieldPage> {
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = generateTextStyle(widget.style);
    textStyle = textStyle.copyWith(fontSize:textSizeDefault, color: Colors.black);
    return/* RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: handleKeyPress,
        child: */ TextFormField(

          controller: widget.textEditingController,
          style: textStyle,
              textAlign: widget.style.textAlign ?? TextAlign.start,
          textDirection: widget.style.direction,
          keyboardType: TextInputType.multiline,
          expands: false,

          maxLines: widget.maxLines,
          textInputAction: TextInputAction.next,
          focusNode: widget.focusNode,
         onFieldSubmitted: (_) => widget.onSubmitted(),
          decoration: new InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                )),
            contentPadding: EdgeInsets.all(5
            ),
            focusColor: navigationBarBackgroundColor,
            fillColor: Colors.red,

            hintText: widget.hint,
            hintMaxLines: 59,
            isDense: true,
          ),
    );
  }

  nextEditableTextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  void handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        widget.onSubmitted();
      } else   if (event.logicalKey == LogicalKeyboardKey.tab) {
        widget.onSubmitted();
      }
      else if (event.data is RawKeyEventDataWeb) {
        final data = event.data as RawKeyEventDataWeb;
        if (data.keyLabel == 'Enter') widget.onSubmitted();
      } else if (event.data is RawKeyEventDataAndroid) {
        final data = event.data as RawKeyEventDataAndroid;
        if (data.keyCode == 13) widget.onSubmitted();
      }
    }
  }
}

TextStyle generateTextStyle(Style style) {
  return TextStyle(
    backgroundColor: style.backgroundColor,
    color: style.color,
    decoration: style.textDecoration,
    decorationColor: style.textDecorationColor,
    decorationStyle: style.textDecorationStyle,
    decorationThickness: style.textDecorationThickness,
    fontFamily: style.fontFamily,
    fontFeatures: style.fontFeatureSettings,
    fontSize: style.fontSize?.size,
    fontStyle: style.fontStyle,
    fontWeight: style.fontWeight,
    letterSpacing: style.letterSpacing,
    shadows: style.textShadow,
    wordSpacing: style.wordSpacing,
    height: style.lineHeight?.size ?? null,
  );
}
