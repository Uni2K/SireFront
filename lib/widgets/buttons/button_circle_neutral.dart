import 'package:flutter/material.dart';

class ButtonCircleNeutral extends StatefulWidget {
  ButtonCircleNeutral({Key? key, required this.icon, required this.onClick})
      : super(key: key);

  final Icon icon;
  final VoidCallback onClick;

  @override
  _ButtonCircleNeutralState createState() => _ButtonCircleNeutralState();
}

class _ButtonCircleNeutralState extends State<ButtonCircleNeutral> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.onClick();
      },
      minWidth: 0,
      elevation: 0.0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: widget.icon,
      shape: CircleBorder(),
    );
  }
}
