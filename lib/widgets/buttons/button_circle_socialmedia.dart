import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/utils/util_color.dart';

enum Types { Twitter, Facebook, Reddit, Skype, Whatsapp, Messenger, Telegram }

extension ParseToString on Types {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class ButtonCircleSocialmedia extends StatelessWidget {
  ButtonCircleSocialmedia({Key? key, required this.type}) : super(key: key);
  final Types type;

  @override
  Widget build(BuildContext context) {
    FaIcon icon = getIcon();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          onPressed: () => getAction(),
          minWidth: 0,
          elevation: 0.0,
          color: icon.color?.withAlpha(30),
          hoverElevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          //fillColor: Colors.white,
          child: icon,
          padding: EdgeInsets.all(25),
          shape: CircleBorder(),
        ),
        SizedBox(
          height: 5,
        ),
        Flexible(
            child: Text(
          getText(),
          style: TextStyle(fontSize: 13),
        ))
      ],
    );
  }

  String getText() {
    return type.toShortString();
  }

  FaIcon getIcon() {
    double size = 25;
    Color color = Colors.black;

    IconData iconData = FontAwesomeIcons.undo;
    switch (type) {
      case Types.Facebook:
        iconData = FontAwesomeIcons.facebook;
        color = ColorUtil.getColorFromHex("#1675F1");

        break;
      case Types.Whatsapp:
        iconData = FontAwesomeIcons.whatsapp;
        color = ColorUtil.getColorFromHex("#24D264");

        break;
      case Types.Telegram:
        iconData = FontAwesomeIcons.telegram;
        color = ColorUtil.getColorFromHex("#0087CB");

        break;
      case Types.Reddit:
        iconData = FontAwesomeIcons.reddit;
        color = ColorUtil.getColorFromHex("#FF4500");

        break;
      case Types.Twitter:
        iconData = FontAwesomeIcons.twitter;
        color = ColorUtil.getColorFromHex("#1CA0F2");
        break;
      case Types.Messenger:
        iconData = FontAwesomeIcons.facebookMessenger;
        color = ColorUtil.getColorFromHex("#0083FF");

        break;
      case Types.Skype:
        iconData = FontAwesomeIcons.skype;
        color = ColorUtil.getColorFromHex("#42A5F5");

        break;
    }
    return FaIcon(
      iconData,
      size: size,
      color: color,
    );
  }

  getAction() {}
}
