import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class TextfieldSelectable extends StatefulWidget {
  TextfieldSelectable({Key? key}) : super(key: key);

  @override
  _TextfieldSelectableState createState() => _TextfieldSelectableState();
}

class _TextfieldSelectableState extends State<TextfieldSelectable> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: dividerColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Expanded(
              child: SelectableText("https://www.google.com/loldasgibtsnicht",
                  style: TextStyle(color: Colors.grey[600])),
            ),
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
                    color: Colors.grey[800],
                    size: 18,
                  ),
                  shape: CircleBorder(),
                )
          ],
        ));
  }
}
