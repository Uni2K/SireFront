import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sire/constants/constant_color.dart';

class NavigationRound extends StatefulWidget {
  NavigationRound({Key? key, this.back=false}) : super(key: key);

  final bool back;

  @override
  _NavigationRoundState createState() => _NavigationRoundState();
}

class _NavigationRoundState extends State<NavigationRound> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      minWidth: 0,
      color: accentColor,
      padding: EdgeInsets.zero,
      shape: CircleBorder(),
      child: Icon(
        widget.back?Icons.navigate_before: Icons.navigate_next,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
