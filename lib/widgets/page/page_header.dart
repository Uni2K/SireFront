import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/widgets/page/headers/header_prototype.dart';

class PageHeader extends StatefulWidget {
  PageHeader({required GlobalKey<PageHeaderState> key, required this.content})
      : super(key: key);

  final HeaderPrototype content;

  @override
  PageHeaderState createState() => PageHeaderState();

  void highlight(bool val) {
    if (key != null && key is GlobalKey<PageHeaderState>) {
      GlobalKey<PageHeaderState> k = key as GlobalKey<PageHeaderState>;
      k.currentState?.highlight(val);
    }
  }
}

class PageHeaderState extends State<PageHeader> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: UtilSize.getHeaderMinHeigth(context),
            maxHeight: UtilSize.getHeaderMaxHeigth(context)),
        child: Container(
          decoration: BoxDecoration(
              color: widget.content.readOnly ? highlightColor : Colors.white,
              border: Border.all(
                  color: isHighlighted
                      ? primaryColor
                      : widget.content.readOnly
                          ? highlightColor
                          : Colors.white,
                  width: 2)),
          margin: EdgeInsets.only(bottom: 10),
          //height: height + (widget.content.readOnly ? 10 : 0),
          child: widget.content,
          width: ((MediaQuery.of(context).size.height * heightPercentage) /
                  sqrt(2)) -
              spacePages * 2,
        ));
  }

  void changeHeaderContent(String type, Map<String, String> text) {
    widget.content.changeHeaderContent(type, text);
  }

  void highlight(bool val) {
    setState(() {
      isHighlighted = val;
    });
  }

}
