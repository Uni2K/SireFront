import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sire/bars/saving/reset.dart';
import 'package:sire/bars/saving/save.dart';
import 'package:sire/constants/constant_dimensions.dart';

class BarSave extends StatefulWidget {
  BarSave({Key? key, required this.save, required this.reset}) : super(key: key);

  final VoidCallback save,reset;

  @override
  _BarSaveState createState() => _BarSaveState();
}

class _BarSaveState extends State<BarSave> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: (MediaQuery.of(context).size.height * heightPercentage) / sqrt(2),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          children: [Reset(onClick:widget.reset), Spacer(),Save(onClick:widget.save)],
        ));
  }
}
