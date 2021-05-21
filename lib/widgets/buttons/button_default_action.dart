import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonDefaultAction extends StatelessWidget {
  ButtonDefaultAction(
      {Key? key,
      required this.onClick,
      required this.text,
      required this.icon,
      this.vertical = false})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onClick;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: MaterialButton(
      onPressed: () {
        onClick();
      },
      minWidth: 0,
      padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: vertical ? 5 : 15),
      elevation: 0.0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      focusNode: FocusNode(skipTraversal: true, descendantsAreFocusable: false),
      color: primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  size: 15,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            )
          : Row(
              children: [
                FaIcon(
                  icon,
                  size: 15,
                  color:  Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 14, color:  Colors.white),
                )
              ],
            ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
