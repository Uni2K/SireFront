import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:get/get.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';

class InputfieldQuill extends StatefulWidget {
  InputfieldQuill({Key? key, required this.initialContent, required this.style,required this.readOnly})
      : super(key: key) {
    initialContent = contentToJSON(initialContent, style);
  }

  String initialContent;
  String? currentContent;
 final bool readOnly;
  final Style style;

  @override
  _InputfieldQuillState createState() => _InputfieldQuillState();
}

String contentToJSON(String content, Style style) {
  Map<String, dynamic> attributes = Map();

  if (style.fontWeight == FontWeight.bold) attributes["bold"] = true;
  if (style.fontStyle == FontStyle.italic) attributes["italic"] = true;

  Map<String, dynamic> jsonMap = Map();
  jsonMap["attributes"] = attributes;
  jsonMap["insert"] = content ;

  String json = "[${jsonEncode(jsonMap)}]";
  return json;
}

class _InputfieldQuillState extends State<InputfieldQuill> {
  late QuillController _controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // print(_controller.document.toPlainText());
    _controller = QuillController(document: Document.fromJson(jsonDecode(widget.initialContent)), selection: TextSelection.collapsed(offset: 0));

    if(!widget.readOnly) {
      _controller.addListener(() {
        widget.currentContent =
            jsonEncode(_controller.document.toDelta().toJson());
      });

      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          //  if(widget.currentContent==null){
          //   _controller.document.delete(0, widget.initialContent.length);
          //sdf}
          ViewModelMain viewModelMain = Get.put(ViewModelMain());
          viewModelMain.updateQuillController(_controller);

        }
      });
    }
    return IgnorePointer(
        ignoring: widget.readOnly,
        child: QuillEditor(
        controller: _controller,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: focusNode,
        autoFocus: false,
        readOnly: widget.readOnly,
        expands: false,
        padding: EdgeInsets.zero));
  }
}
