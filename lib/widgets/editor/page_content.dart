import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';

class PageContent extends StatefulWidget {
  PageContent({Key? key, required this.content}) : super(key: key);

  final String content;

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: spacePages, vertical: spacePages),
      width:
          ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2)) -
              spacePages * 2,
      child: Align(
          alignment: Alignment.centerRight, child: Html(data: widget.content)),
    );
  }
}
