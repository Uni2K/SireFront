import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';

class Save extends StatefulWidget {
  Save({Key? key}) : super(key: key);

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return
      RawMaterialButton(
        fillColor: navigationBarBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      onPressed: () {},
      child:
          Row(
        children: [
          FaIcon(FontAwesomeIcons.print, size: 15, color: Colors.white,),
          SizedBox(
            width: 10,
          ),
          Text("Speichern", style: TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
