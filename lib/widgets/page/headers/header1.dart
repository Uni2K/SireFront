import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:sire/widgets/input/inputfield_quill.dart';
import 'package:sire/widgets/page/headers/header_prototype.dart';

class Header1 extends HeaderPrototype {

  Header1({bool readOnly=true}) : super(readOnly:readOnly );


  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      InputfieldQuill(readOnly: true, style: Style(fontWeight: FontWeight.bold), initialContent: 'Bemerkung',),
      InputfieldQuill(readOnly: true, style: Style(fontWeight: FontWeight.normal), initialContent: 'Max Mustermann',),
      InputfieldQuill(readOnly: true, style: Style(fontWeight: FontWeight.normal), initialContent: 'Max Mustermann',),
      InputfieldQuill(readOnly: true, style: Style(fontWeight: FontWeight.normal), initialContent: 'Max Mustermann',),
      InputfieldQuill(readOnly: true, style: Style(fontWeight: FontWeight.normal), initialContent: 'Max Mustermann',),
    ],),);
  }
}
