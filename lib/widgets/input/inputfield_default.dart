import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class InputfieldDefault extends StatefulWidget {
  InputfieldDefault(
      {Key? key, required this.hint, required this.textEditingController})
      : super(key: key);

  final String hint;
  final TextEditingController textEditingController;

  @override
  _InputfieldDefaultState createState() => _InputfieldDefaultState();
}

class _InputfieldDefaultState extends State<InputfieldDefault> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint,
          style: TextStyle(fontSize: 12, color: buttonTextColor),
        ),
        SizedBox(
          height: 2,
        ),
        TextField(
          readOnly: false,
          controller: widget.textEditingController,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            fillColor: buttonBackgroundColor,
            filled: true,
            isDense: true,
            border: new OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: const BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
