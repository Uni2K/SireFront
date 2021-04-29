import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonGo extends StatefulWidget {
  ButtonGo({Key? key, required this.onClick,  required this.text})
      : super(key: key);

  final String text;
  final VoidCallback onClick;

  @override
  _ButtonGoState createState() => _ButtonGoState();
}

class _ButtonGoState extends State<ButtonGo> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(child:MaterialButton(
      onPressed: () {
        widget.onClick();
      },
      minWidth: 0,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      elevation: 0.0,
      color: buttonBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child:Row(children: [Icon(Icons.login), SizedBox(width: 15,), Text(widget.text, style: TextStyle(fontSize: 19),)],),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
