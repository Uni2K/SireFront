import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sire/constants/constant_color.dart';

enum Types { Twitter, Facebook, Reddit, Skype, Whatsapp, Messenger, Telegram }

extension ParseToString on Types {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class ButtonCircleSocialmedia extends StatefulWidget {
  ButtonCircleSocialmedia({Key? key, required this.type}) : super(key: key);

  final Types type;

  @override
  _ButtonCircleSocialmediaState createState() =>
      _ButtonCircleSocialmediaState();
}

class _ButtonCircleSocialmediaState extends State<ButtonCircleSocialmedia> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          onPressed: () => getAction(),
          minWidth: 0,
          elevation: 0.0,
          color: dividerColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //fillColor: Colors.white,
          child: SvgPicture.asset(getIcon(), height: 30,width: 30,),
       
       
       
         shape: CircleBorder(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(getText(), style: TextStyle(fontSize: 13),)
      ],
    );
  }

  String getText() {
    return widget.type.toShortString();
  }

  String getIcon() {

    switch (widget.type) {
      case Types.Facebook:
        return "assets/036-facebook.svg";
      case Types.Whatsapp:
        return "assets/005-whatsapp.svg";
      case Types.Telegram:
        return "assets/036-facebook.svg";
      case Types.Reddit:
        return "assets/018-reddit.svg";
      case Types.Twitter:
        return "assets/008-twitter.svg";
      case Types.Messenger:
        return "assets/036-facebook.svg";
      case Types.Skype:
        return "assets/015-skype.svg";
    }
  }

  getAction() {}
}
