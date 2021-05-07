import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonCircleNeutral extends StatefulWidget {
  ButtonCircleNeutral({Key? key, required this.icon, required this.onClick, this.background=false})
      : super(key: key);

  final Icon icon;
  final bool background;
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
      focusNode: FocusNode(skipTraversal: true),
      minWidth: 0,
      elevation: 0.0,
      padding: EdgeInsets.zero,
      color: widget.background?dividerColor:null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //fillColor: Colors.white,
      child: widget.icon,
      shape: CircleBorder(),
    );
  }
}
