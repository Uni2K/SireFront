import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoCreatedby extends StatefulWidget {
  LogoCreatedby({Key? key}) : super(key: key);

  @override
  _LogoCreatedbyState createState() => _LogoCreatedbyState();
}

class _LogoCreatedbyState extends State<LogoCreatedby> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Erstellt mit"),
        SizedBox(
          width:8,
        ),
        FaIcon(
          FontAwesomeIcons.solidHeart,
          color: Colors.red,
          size: 15,
        ),
        SizedBox(
          width: 8,
        ),
        Text("und"),
        SizedBox(
          width: 8,
        ),
       FlutterLogo(size: 15,),
        SizedBox(
          width: 8,
        ),
        Text("in Berlin."),
      ],
    );
  }
}
