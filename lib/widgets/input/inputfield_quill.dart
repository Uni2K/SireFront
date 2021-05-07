import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/default_styles.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:get/get.dart';
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
        selection: TextSelection.collapsed(
            offset: 0));
    if (!widget.readOnly) {
      _controller.addListener(() {
        if(!focusNode.hasFocus)return;
        int lineNumberEdited =
        getLineNumber(_controller.document.toPlainText());

        if (lineNumberEdited != currentEditingLine) {
          currentEditingLine = lineNumberEdited;

          String lineInitial = getLine(widget.initialContent);
          String lineEdited = getLine(_controller.document.toPlainText());
          if (lineInitial == lineEdited)
          {

            //Line is edited
            TextSelection selection = updateSelection();
            _controller.updateSelection(selection, ChangeSource.REMOTE);
          }
        }
      });

      focusNode.addListener(() {
            if (focusNode.hasFocus) {
              print("added Focus:  ${widget.initialContent}");

                   _controller.updateSelection(
                  updateSelection(), ChangeSource.REMOTE);
                   
              ViewModelMain viewModelMain = Get.put(ViewModelMain());
              viewModelMain.updateQuillController(_controller);
            } else {
              _controller.blockedFocus=true;
              _controller.updateSelection(
                  TextSelection.collapsed(offset: 0), ChangeSource.REMOTE);
              print("removed Focus: ${widget.initialContent}");
              currentEditingLine = -1;
              _controller.blockedFocus=false;


            }
          });
    }
  }

  ///Highlights the row
  TextSelection updateSelection() {
    String text = _controller.document.toPlainText();
    int cursorPosition = _controller.selection.baseOffset;
    List<String> lines = text.split("\n");

    String searchedContent = "";
    String lineWithCursor = "";
    for (String line in lines) {
      line += "\n";

      if (cursorPosition < line.length + searchedContent.length) {
        lineWithCursor = line;
        break;
      }
      searchedContent += line;
    }

    if (lineWithCursor.isBlank ?? false) {
      print("blank");
      return TextSelection.collapsed(offset: searchedContent.length);
    } else
      return TextSelection(
          extentOffset: searchedContent.length + (lineWithCursor).length - 1,
          baseOffset: searchedContent.length);
  }

  int getLineNumber(String text) {
    int cursorPosition = _controller.selection.baseOffset;
    List<String> lines = text.split("\n");
    String searchedContent = "";

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      if (line.isEmpty && cursorPosition == searchedContent.length + 2) {
        return lines.indexOf(line);
      }
      if (cursorPosition < line.length + searchedContent.length) {
        return lines.indexOf(line);
      }
      searchedContent += line;
    }
    return -1;
  }

  String getLine(String text) {
    int cursorPosition = _controller.selection.baseOffset;
    List<String> lines = text.split("\n");
    String searchedContent = "";

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      if (line.isEmpty && cursorPosition == searchedContent.length + 2) {
        return line;
      }
      if (cursorPosition < line.length + searchedContent.length) {
        return line;
      }
      searchedContent += line;
    }
    return "";
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
        child: QuillEditor(
            controller: _controller,
            scrollController: ScrollController(),
            scrollable: true,
            focusNode: focusNode,
            autoFocus: false,
            customStyles: DefaultStyles(placeHolder: placeholder),
            placeholder: widget.placeholding ? widget.initialContentJSON : null,
            readOnly: widget.readOnly,
            expands: false,
            padding: EdgeInsets.zero));
  }
}
