import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class TextfieldSelectable extends StatefulWidget {
  TextfieldSelectable({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  _TextfieldSelectableState createState() => _TextfieldSelectableState();
}

class _TextfieldSelectableState extends State<TextfieldSelectable> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        decoration: BoxDecoration(
            color: buttonBackgroundColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Flexible(child: SelectableText(widget.text,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey[600]))),
            SizedBox(
              width: 10,
            ),
          MaterialButton(
                  onPressed: () {},
                  elevation: 0.0,
                  padding: EdgeInsets.all(0),
                  minWidth: 0,
                  height: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //fillColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.copy,
                    color: buttonTextColor,
                    size: 16,
                  ),
                  shape: CircleBorder(),
                )
          ],
        ));
  }
}
