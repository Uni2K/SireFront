import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/switchs/switch_prototype.dart';

class SwitcherDarkmode extends StatefulWidget {
  SwitcherDarkmode({Key? key}) : super(key: key);

  @override
  _SwitcherDarkmodeState createState() => _SwitcherDarkmodeState();
}

class _SwitcherDarkmodeState extends State<SwitcherDarkmode> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child:SizedBox(
        height: 25,
        width: 50,
        child: FlutterSwitch(
          width: 50.0,
          height: 25.0,
          toggleSize: 25.0,
          value: _value,
          borderRadius: 5.0,
          padding: 0.0,
          activeColor: buttonBackgroundColor,
          inactiveColor: buttonBackgroundColor,
          activeToggleColor: buttonBackgroundColor,
          inactiveToggleColor: buttonBackgroundColor,
          activeIcon: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: switchOnColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                  child: Icon(
                Icons.nightlight_round,
                color: Colors.deepPurple[600],
                size: 17,
              ))),
          inactiveIcon: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: switchOnColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                  child: Icon(
                Icons.wb_sunny,
                size: 17,
                color: Colors.amber,
              ))),
          onToggle: (val) {
            setState(() {
              _value = val;
            });
          },
        )));
  }
}
