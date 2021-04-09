import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/widgets/editor/page_inputfield.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

// ignore: must_be_immutable
class PageCombined extends StatefulWidget {
  PageCombined(
      {Key? key,
      this.content,
      this.background = false,
      required this.contentType})
      : super(key: key);

  final String? content;
  final bool background;
  final ContentTypes contentType;
  RxBool isDisable=true.obs;
  @override
  PageCombinedState createState() => PageCombinedState();
}

class PageCombinedState extends State<PageCombined> {
  @override
  Widget build(BuildContext context) {
    return widget.background ? getBackground() : getContent();
  }

  Widget getContent() {
    return Obx(()=> AbsorbPointer(
        absorbing: widget.isDisable.value,
        child: Container(
            padding: getPadding(),
            margin: const EdgeInsets.symmetric(
                horizontal: spacePages, vertical: spacePages),
            width: ((MediaQuery.of(context).size.height * heightPercentage) /
                    sqrt(2)) -
                spacePages * 2,
            child: Html(
                customRender: getCustomRenderer(),
                data: widget.content ?? ""))));
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

    switch (widget.contentType) {
      case ContentTypes.Header:
        return EdgeInsets.only(
            left: paddingTLR, right: paddingTLR, top: paddingTLR);
      case ContentTypes.Body:
        return EdgeInsets.only(left: paddingTLR, right: paddingTLR);
      case ContentTypes.Footer:
        return EdgeInsets.only(
            left: paddingTLR, right: paddingTLR, bottom: paddingB);
    }
  }

  getCustomRenderer() {
    return {
      "b": (RenderContext context, Widget child, Map<String, String> attributes,
          _) {
        return generateInputField(child);
      },
      "i": (RenderContext context, Widget child, Map<String, String> attributes,
          _) {
        return generateInputField(child);
      },
      "span": (RenderContext context, Widget child,
          Map<String, String> attributes, _) {
        return generateInputField(child);
      },
    };
  }

  generateInputField(Widget child) {
    if (child is ContainerSpan?) {
      ContainerSpan? containerSpan = child as ContainerSpan?;
      if (containerSpan != null && containerSpan.children != null) {
        List<InlineSpan> children = containerSpan.children!;

        for (var value in children) {
          if (value is TextSpan) {
            return PageInputfield(
                hint: value.text ?? "", style: containerSpan.style);
          }
        }
      }
    }

    return "";
  }
}
