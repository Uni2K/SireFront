import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:sire/constants/constant_color.dart';

class PageInputfield extends StatefulWidget {
  PageInputfield({
    Key? key,
    required this.hint,
    required this.style,
  }) : super(key: key);

  final String hint;
  final Style style;

  TextEditingController textEditingController = new TextEditingController();

  @override
  _PageInputfieldState createState() => _PageInputfieldState();
}

//https://github.com/fluttercandies/extended_text
//https://github.com/flutter/flutter/issues/30688
class _PageInputfieldState extends State<PageInputfield> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = generateTextStyle(widget.style);
    textStyle = textStyle.copyWith(fontSize: 14);
    return IntrinsicWidth(
        child: TextField(
      enableInteractiveSelection: true,
      controller: widget.textEditingController,
      style: textStyle,
      // TextStyle(fontSize: 14, inherit: textStyle.inherit, fontWeight: textStyle.fontWeight, backgroundColor: textStyle.backgroundColor, height: textStyle.height, fontStyle: textStyle.fontStyle ),
      textAlign: widget.style.textAlign ?? TextAlign.start,
      textDirection: widget.style.direction,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      focusNode: FocusNode(),
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => nextEditableTextFocus(context),
      // textScaleFactor: textScaleFactor,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            )),
        contentPadding: EdgeInsets.all(7),
        focusColor: navigationBarBackgroundColor,
        fillColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            )),
        hintText: widget.hint,
        hintMaxLines: 59,
        isDense: true,
      ),
    ));
  }

  nextEditableTextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
    /* do {
      FocusScope.of(context).nextFocus();
    } while (FocusScope.of(context).focusedChild?.context?.widget is! EditableText);*/
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
