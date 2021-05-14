import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/tiles/tile_address.dart';

enum TileContent { addSignature, formatEmail, spellCheck, addAddress }

class ListTileEditor extends StatelessWidget {
  ListTileEditor({Key? key, required this.contentType}) : super(key: key);
  final TileContent contentType;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20, left: 3, right: 3),
        child: Material(
          elevation: 4,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            canRequestFocus: true,
            borderRadius: BorderRadius.circular(5),
            hoverColor: getHoverColor(),
            enableFeedback: false,
            child: Ink(
                child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              width: 200,
              child: IntrinsicHeight(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: getCircleColor(), shape: BoxShape.circle)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        getText(),
                        style: TextStyle(fontSize: 13),
                      ),
                      Spacer(),
                      ButtonCircleNeutral(
                        icon: Icon(
                          Icons.delete_rounded,
                          size: 16,
                          color: buttonTextColor,
                        ),
                        background: false,
                        onClick: () => null,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      ButtonCircleNeutral(
                        icon: Icon(Icons.settings,
                            size: 16, color: buttonTextColor),
                        background: false,
                        onClick: () => null,
                      ),
                    ],
                  ),
                  Flexible(child: getContent())
                ],
              )),
            )),
          ),
        ));
  }

  Widget getContent() {
    switch (contentType) {
      case TileContent.addSignature:
        break;
      case TileContent.formatEmail:
        // TODO: Handle this case.
        break;
      case TileContent.spellCheck:
        // TODO: Handle this case.
        break;
      case TileContent.addAddress:
        return TileAddress();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "testgmail.com",
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        SizedBox(
          width: 15,
        ),
        Icon(
          Icons.arrow_forward_rounded,
          size: 15,
          color: buttonTextColor,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          " test@gmail.com ",
          style: TextStyle(color: Colors.white, backgroundColor: primaryColor),
        ),
      ],
    );
  }

  Color getCircleColor() {
    switch (contentType) {
      case TileContent.addSignature:
        return primaryColor;
      case TileContent.formatEmail:
        return Colors.orange;
      case TileContent.spellCheck:
        return Colors.orange;
      case TileContent.addAddress:
        return primaryColor;
    }
  }

  String getText() {
    switch (contentType) {
      case TileContent.addSignature:
        return "Signatur hinzufügen";
      case TileContent.formatEmail:
        return "E-Mail Adresse formatieren";
      case TileContent.spellCheck:
        return "Rechtschreibprüfung";
      case TileContent.addAddress:
        return "Adressen hinzufügen";
    }
  }

  Color getHoverColor() {
    switch (contentType) {
      case TileContent.addSignature:
        return dividerColor;
      case TileContent.formatEmail:
        return dividerColor;
      case TileContent.spellCheck:
        return dividerColor;
      case TileContent.addAddress:
        return Colors.white;
    }
  }
}
