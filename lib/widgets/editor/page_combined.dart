import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class PageCombined extends StatefulWidget {
  PageCombined({Key? key, this.content, this.background = false, required this.contentType})
      : super(key: key);

  final String? content;
  final bool background;
  final ContentTypes contentType;

  @override
  _PageCombinedState createState() => _PageCombinedState();
}

class _PageCombinedState extends State<PageCombined> {
  @override
  Widget build(BuildContext context) {
    return widget.background ? getBackground() : getContent();
  }

  Widget getContent() {
    return Container(
      padding: getPadding(),
      margin: const EdgeInsets.symmetric(
          horizontal: spacePages, vertical: spacePages),
      width:
          ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2)) -
              spacePages * 2,
      child: Html(data: widget.content ?? ""));
  }

  Widget getBackground() {
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: spacePages, vertical: spacePages),
        padding: getPadding(),
        width: ((MediaQuery.of(context).size.height * heightPercentage) /
                sqrt(2)) -
            spacePages * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ));
  }

  ///2.5cm top,left, right, 2cm bottom
  getPadding() {
    double width =
        ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2)) -
            spacePages * 2;

    double paddingTLR = paperMarginTLRRelative * width;
    double paddingB = paperMarginBRelative * width;

    switch(widget.contentType){
      case ContentTypes.Header: return EdgeInsets.only(left: paddingTLR, right: paddingTLR, top: paddingTLR);
      case ContentTypes.Body: return EdgeInsets.only(left: paddingTLR, right: paddingTLR);
      case ContentTypes.Footer: return EdgeInsets.only(left: paddingTLR, right: paddingTLR, bottom: paddingB);
    }


  }
}
