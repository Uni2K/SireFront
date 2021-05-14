import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class ButtonCircleNeutral extends StatelessWidget {
  ButtonCircleNeutral(
      {Key? key,
      required this.icon,
      required this.onClick,
      this.background = false})
      : super(key: key);

  final Icon icon;
  final bool background;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onClick();
      },
      focusNode: FocusNode(skipTraversal: true),
      minWidth: 0,
      elevation: 0.0,
      padding: EdgeInsets.zero,
      color: background ? dividerColor : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: icon,
      shape: CircleBorder(),
    );
  }
}
