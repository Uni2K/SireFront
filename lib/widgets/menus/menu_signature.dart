import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class MenuSignature extends StatefulWidget {
  MenuSignature({Key? key, required this.signature, this.onReset}) : super(key: key);
  final ByteData signature;

  final VoidCallback? onReset; //TODO so inkonsistent, nur reset nicht delete


  @override
  _MenuSignatureState createState() => _MenuSignatureState();
}

class _MenuSignatureState extends State<MenuSignature> {
  int _selection = -1;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.all(0),
      elevation: 3,
      iconSize: 13,
      icon: FaIcon(FontAwesomeIcons.slidersH, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      onSelected: (int result) {
        setState(() {
          _selection = result;
        });
      },
      initialValue: _selection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          height: 30,
          value: 0,
          onTap: widget.onReset,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FaIcon(
              FontAwesomeIcons.undo,
              color: buttonTextColor,
              size: 14,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Zurücksetzen',
              style: TextStyle(color: buttonTextColor, fontSize: 13),
            )
          ]),
        ),
        PopupMenuItem<int>(
          height: 30,
          value: 1,
          onTap: (){
            ViewModelMain viewModelMain = Get.put(ViewModelMain());
            viewModelMain.signatures.remove(widget.signature);
          },
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FaIcon(
              FontAwesomeIcons.solidTrashAlt,
              color: buttonTextColor,
              size: 14,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Löschen',
              style: TextStyle(color: buttonTextColor, fontSize: 13),
            )
          ]),
        ),
      ],
    );
  }
}
