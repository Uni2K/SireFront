import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonDefaultLight extends StatefulWidget {
  ButtonDefaultLight({Key? key, required this.onClick,  required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onClick;

  @override
  _ButtonDefaultLightState createState() => _ButtonDefaultLightState();
}

class _ButtonDefaultLightState extends State<ButtonDefaultLight> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(child:MaterialButton(
      onPressed: () {
        widget.onClick();
      },
      minWidth: 0,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      elevation: 0.0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: buttonBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child:Row(children: [Icon(widget.icon,size: 19, color: buttonTextColor,), SizedBox(width: 10,), Text(widget.text, style: TextStyle(fontSize: 15,color: buttonTextColor),)],),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
