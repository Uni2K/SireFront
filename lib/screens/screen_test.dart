import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_signature/signature.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/dialogs/dialog_signature.dart';

class ScreenTest extends StatefulWidget {
  ScreenTest({Key? key}) : super(key: key);

  @override
  _ScreenTestState createState() => _ScreenTestState();
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _ScreenTestState extends State<ScreenTest> {
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.7,
    velocityRange: 2.0,
  );

  @override
  void initState() {
    super.initState();
  }

  WhyFarther _selection = WhyFarther.harder;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Container(
            child: Center(
                child: PopupMenuButton<WhyFarther>(
          padding: EdgeInsets.all(0),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          onSelected: (WhyFarther result) {
            setState(() {
              _selection = result;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
            PopupMenuItem<WhyFarther>(
              height: 35,
              value: WhyFarther.harder,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                FaIcon(
                  FontAwesomeIcons.undo,
                  color: buttonTextColor,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Zurücksetzen',
                  style: TextStyle(color: buttonTextColor,fontSize: 14),
                )
              ]),
            ),
            PopupMenuItem<WhyFarther>(
              height: 35,

              value: WhyFarther.harder,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                FaIcon(
                  FontAwesomeIcons.solidTrashAlt,
                  color: buttonTextColor,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Löschen',
                  style: TextStyle(color: buttonTextColor,fontSize: 14),
                )
              ]),
            ),
          ],
        ))));
  }
}
