import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/default_styles.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:get/get.dart';
import 'package:sire/utils/util_text.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:tuple/tuple.dart';

class InputfieldQuill extends StatefulWidget {
  InputfieldQuill({
    Key? key,
    required this.initialContent,
    required this.style,
    required this.readOnly,
    this.placeholding = false,
  }) : super(key: key) {
    initialContentJSON = contentToJSON(initialContent, style);
  }

  String initialContent;
  String initialContentJSON = "";
  String? currentContent;
  final bool readOnly;
  final bool placeholding;
  final Style style;

  @override
  _InputfieldQuillState createState() => _InputfieldQuillState();

  String contentToJSON(String content, Style style) {
    Map<String, dynamic> attributes = Map();

    if (style.fontWeight == FontWeight.bold) attributes["bold"] = true;
    if (style.fontStyle == FontStyle.italic) attributes["italic"] = true;
    Map<String, dynamic> jsonMap = Map();
    if (placeholding) attributes["placeholder"] = true;
    jsonMap["attributes"] = attributes;

    if(content.split("\n").length==2) {
      String lastChar = content.substring(content.length - 1, content.length);
      if (lastChar == "\n") content = content.substring(0, content.length - 1);
    }
    jsonMap["insert"] = content;

    String json = "[${jsonEncode(jsonMap)}]";
    return json;
  }
}

class _InputfieldQuillState extends State<InputfieldQuill> {
  late QuillController _controller;
  FocusNode focusNode = FocusNode();
  int currentEditingLine = -1;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
        document: widget.placeholding
            ? Document()
            : Document.fromJson(jsonDecode(widget.initialContentJSON)),
        selection: TextSelection.collapsed(offset: 0));
    if (!widget.readOnly) {
      _controller.addListener(() {
        print( jsonEncode(_controller.document.toDelta().toJson()));
        if (!focusNode.hasFocus) return;
        int lineNumberEdited = UtilText.getLineNumber(
            _controller.document.toPlainText(),
            _controller.selection.baseOffset);

        if (lineNumberEdited != currentEditingLine) {
          currentEditingLine = lineNumberEdited;

          String? lineInitial = UtilText.getLine(
              widget.initialContent, _controller.selection.baseOffset);
          String? lineEdited = UtilText.getLine(
              _controller.document.toPlainText(),
              _controller.selection.baseOffset);
          if (lineEdited==null || lineInitial == lineEdited) {
            //Line is edited -> or new line
            TextSelection selection = UtilText.selectLine(
                text: _controller.document.toPlainText(),
                lineNumber: lineNumberEdited);
            _controller.updateSelection(selection, ChangeSource.REMOTE);
          }
        }
      });


      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          int lineNumberEdited = UtilText.getLineNumber(
              _controller.document.toPlainText(),
              _controller.selection.baseOffset);
          _controller.updateSelection(
              UtilText.selectLine(
                  text: _controller.document.toPlainText(),
                  lineNumber: lineNumberEdited),
              ChangeSource.REMOTE);

          ViewModelMain viewModelMain = Get.put(ViewModelMain());
          viewModelMain.updateQuillController(_controller);
        } else {

          _controller.blockedFocus = true;
          _controller.updateSelection(
              TextSelection.collapsed(offset: 0), ChangeSource.REMOTE);
          currentEditingLine = -1;
          _controller.blockedFocus = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    DefaultTextBlockStyle placeholder = DefaultTextBlockStyle(
        defaultTextStyle.style.copyWith(
          color: Colors.grey.withOpacity(0.8),
          fontSize: 16,
          height: 1.3,
        ),
        const Tuple2(0, 0),
        const Tuple2(0, 0),
        null);

    return IgnorePointer(
        ignoring: widget.readOnly,
        child:  QuillEditor(
                decider: (key) {
                  int currentLine = UtilText.getLineNumber(
                      _controller.document.toPlainText(),
                      _controller.selection.baseOffset);
                  int totalLineNumber = UtilText.getTotalLineNumber(
                      _controller.document.toPlainText());
                  bool re = currentLine == totalLineNumber-1;
                  if (!re) {
                    //move line
                    _controller.updateSelection(
                        UtilText.selectNextLine(
                            _controller.document.toPlainText(),
                           currentLine),
                        ChangeSource.REMOTE);
                  }

                  return re;
                },
                controller: _controller,
                scrollController: ScrollController(),
                scrollable: true,
                focusNode: focusNode,
                autoFocus: false,
                customStyles: DefaultStyles(placeHolder: placeholder),
                placeholder:
                    widget.placeholding ? widget.initialContentJSON : null,
                readOnly: widget.readOnly,
                expands: false,
                padding: EdgeInsets.zero));
  }
}
