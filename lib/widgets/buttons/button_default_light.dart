import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonDefaultLight extends StatefulWidget {
  ButtonDefaultLight(
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
  _ButtonDefaultLightState createState() => _ButtonDefaultLightState();
}

class _ButtonDefaultLightState extends State<ButtonDefaultLight> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: MaterialButton(
      onPressed: () {
        widget.onClick();
      },
      minWidth: 0,
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: widget.vertical ? 5 : 15),
      elevation: 0.0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      focusNode: FocusNode(skipTraversal: true, descendantsAreFocusable: false),
      color: buttonBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: widget.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  widget.icon,
                  size: 15,
                  color: buttonTextColor,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 14, color: buttonTextColor),
                )
              ],
            )
          : Row(
              children: [
                FaIcon(
                  widget.icon,
                  size: 15,
                  color: buttonTextColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 14, color: buttonTextColor),
                )
              ],
            ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
