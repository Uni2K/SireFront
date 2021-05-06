import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';

enum TileContent { addSignature, formatEmail, spellCheck }

class ListTileEditor extends StatefulWidget {
  ListTileEditor({Key? key, required this.contentType}) : super(key: key);
  final TileContent contentType;

  @override
  _ListTileEditorState createState() => _ListTileEditorState();
}

class _ListTileEditorState extends State<ListTileEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20,left: 3,right: 3),
        child: Material(
          elevation: 4,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => {},
            // mouseCursor: resolvedMouseCursor,
            enableFeedback: true,
            child: Ink(
                child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              width: 200,
              height: 85,
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
                              color: Colors.orange, shape: BoxShape.circle)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Fehlende Signatur",
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

                Expanded(child:  getContent())
                ],
              ),
            )),
          ),
        ));
  }

  Widget getContent() {
    switch (widget.contentType) {
      case TileContent.addSignature:
        break;
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
        Icon(Icons.arrow_forward_rounded, size: 15,color: buttonTextColor,),
        SizedBox(
          width: 15,
        ),
        Text(
          " test@gmail.com ",
          style: TextStyle(color: Colors.white, backgroundColor: navigationBarBackgroundColor),

        ),
      ],
    );
  }
}
