import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonDownload extends StatelessWidget {
  ButtonDownload(
      {Key? key, required this.onClick, required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: MaterialButton(
      onPressed: () {
        onClick();
      },
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      color: primaryColor,
      focusNode: FocusNode(skipTraversal: true, descendantsAreFocusable: false),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: Row(
        children: [
          FaIcon(
            icon,
            color: Colors.white,
            size: 19,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ));
  }
}
