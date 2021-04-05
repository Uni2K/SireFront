import 'dart:math';

import 'package:flutter/material.dart';

class PageEditing extends StatefulWidget {
  PageEditing({Key? key}) : super(key: key);

  @override
  PageEditingState createState() => PageEditingState();
}

class PageEditingState extends State<PageEditing> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              spreadRadius: 30,
              blurRadius: 50,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child:AspectRatio(
        aspectRatio: 1 / sqrt(2),
        child: Container(
          color: Colors.white,
        )));
  }
}
