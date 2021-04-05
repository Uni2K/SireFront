import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reset extends StatefulWidget {
  Reset({Key? key, required this.onClick}) : super(key: key);
  final VoidCallback onClick;
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return

      RawMaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      onPressed: () => widget.onClick(),
      child: Opacity(
          opacity: 0.6,
          child:Row(
        children: [
          FaIcon(FontAwesomeIcons.undo, size: 15,),
          SizedBox(
            width: 10,
          ),
          Text("Zurücksetzen", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
        ],
      )),
    );
  }
}
