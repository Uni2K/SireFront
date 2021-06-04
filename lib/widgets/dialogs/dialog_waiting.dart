import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class DialogWaiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.wait,
      child:
    Container(
      child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.hourglassHalf,
                  size: 35,
                  color: primaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bitte warten...",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontFamily: "Berkshire")),
                    Text(" Ihr Dokument wird erstellt!",
                        style: TextStyle(fontSize: 13, color: primaryColor))
                  ],
                )
              ],
            ),
          )),
    ));
  }
}
