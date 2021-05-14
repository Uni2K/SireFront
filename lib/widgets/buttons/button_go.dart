import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonGo extends StatelessWidget {
  ButtonGo({Key? key, required this.onClick, required this.text})
      : super(key: key);

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: MaterialButton(
      onPressed: () {
        onClick();
      },
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      elevation: 0.0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      color: buttonBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.login),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 19),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
