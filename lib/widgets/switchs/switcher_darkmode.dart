import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sire/constants/constant_color.dart';

class SwitcherDarkmode extends StatefulWidget {
  SwitcherDarkmode({Key? key}) : super(key: key);

  @override
  _SwitcherDarkmodeState createState() => _SwitcherDarkmodeState();
}

class _SwitcherDarkmodeState extends State<SwitcherDarkmode> {
    bool _value=false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:30,width: 60,child:FlutterSwitch(
      width: 60.0,
      height: 30.0,
      toggleSize: 25.0,
      value:_value,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: Color(0xFF6E40C9),
      inactiveToggleColor: Color(0xFF2F363D),

      activeColor: Color(0xFF271052),
      inactiveColor: buttonBackgroundColor,
      activeIcon: Icon(
        Icons.nightlight_round,
        color: Color(0xFFF8E3A1),
      ),
      inactiveIcon: Icon(
        Icons.wb_sunny,
        color: Color(0xFFFFDF5D),
      ),
      onToggle: (val) {
        setState(() {
          _value= val;
        });
      },
    ));
  }
}
