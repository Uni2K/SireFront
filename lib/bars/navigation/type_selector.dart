import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class TypeSelector extends StatefulWidget {
  TypeSelector({Key? key}) : super(key: key);

  @override
  _TypeSelectorState createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Container(
      height: 35,
      color: navigationBarBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Center(
          child: Text(
        "Anschreiben",
        style: TextStyle(color: Colors.white, fontSize: 15),
      )),
    ));
  }
}
