import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

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

      // textScaleFactor: textScaleFactor,
      decoration: new InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(7),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(color: Colors.blue, )),
        hintText: widget.hint,
        hintMaxLines: 59,
        isDense: true,
      ),
    ));
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
