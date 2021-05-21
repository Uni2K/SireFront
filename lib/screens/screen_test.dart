import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:sire/widgets/dialogs/dialog_signature.dart';

class ScreenTest extends StatefulWidget {
  ScreenTest({Key? key}) : super(key: key);

  @override
  _ScreenTestState createState() => _ScreenTestState();
}

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

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.grey,
        child: DialogSignature(onFinish: ()=>null,));
  }
}
