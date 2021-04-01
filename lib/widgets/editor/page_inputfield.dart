import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageInputfield extends StatefulWidget {
  PageInputfield({Key? key, required this.hint, this.bold = false, this.italic=false})
      : super(key: key);

  final String hint;
  final bool bold,italic;

  TextEditingController textEditingController = new TextEditingController();

  @override
  _PageInputfieldState createState() => _PageInputfieldState();
}

class _PageInputfieldState extends State<PageInputfield> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(child:TextField(
      controller: widget.textEditingController,
      style: TextStyle(
          fontSize: 14,
          fontWeight: widget.bold? FontWeight.bold: FontWeight.normal, fontStyle: widget.italic?FontStyle.italic: FontStyle.normal),
      decoration: new InputDecoration.collapsed(hintText: widget.hint),
    ));
  }
}
