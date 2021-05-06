import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonDownload extends StatefulWidget {
  ButtonDownload({Key? key, required this.onClick,  required this.text,required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onClick;

  @override
  _ButtonDownloadState createState() => _ButtonDownloadState();
}

class _ButtonDownloadState extends State<ButtonDownload> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(child:MaterialButton(
      onPressed: () {
        widget.onClick();
      },
      minWidth: 0,
        padding: EdgeInsets.symmetric(horizontal: 17,vertical: 15),
      color: navigationBarBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child:Row(children: [FaIcon(widget.icon, color: Colors.white,size: 19,), SizedBox(width: 10,), Text(widget.text, style: TextStyle(fontSize: 15, color: Colors.white), )],),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
