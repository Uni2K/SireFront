import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/objects/dto_header.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/input/inputfield_page.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class PageHeader extends StatefulWidget {
  PageHeader(
      {Key? key, this.content, required this.isDisable, this.onNextFocus})
      : super(key: key);

  final DTOHeader? content;
  final bool isDisable;
  final ValueChanged<FocusNode>? onNextFocus;

  @override
  PageHeaderState createState() => PageHeaderState();
}

class PageHeaderState extends State<PageHeader> {
  List<FocusNode> focusNodes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    double widthViewer = MediaQuery.of(context).size.width * viewerWidth;
    double widthPage = min(
        MediaQuery.of(context).size.height * heightPercentage,
        widthViewer * 0.9);
    double height = widthPage * sqrt(2) * headerPercentage;

    return AbsorbPointer(
        absorbing: false,
        child: Container(
            height: height,
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
            ),

            width: ((MediaQuery.of(context).size.height * heightPercentage) /
                    sqrt(2)) -
                spacePages * 2,
            child: Html(
                style: {
                  "body": Style(margin: EdgeInsets.all(0), ), // <-- remove the margin
                //  "p": Style(  width: 200)
                },
                 customRender: getCustomRenderer(),
                data: widget.content?.content ?? "")));
  }

  List<FocusNode> getFocusNodes() {
    return focusNodes;
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
      "div": (RenderContext context, Widget child,
          Map<String, String> attributes, _) {
        return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [


            IntrinsicWidth(child:child),

          ],
        ));
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
            FocusNode focusNode = FocusNode(debugLabel: value.text);
            if (focusNodes.length == 0 && !widget.isDisable) {
              focusNode.requestFocus();
            }

            focusNodes.add(focusNode);
            return InputfieldPage(
                focusNode: focusNode,
                onSubmitted: () {
                  widget.onNextFocus!(focusNode);
                },
                hint: value.text ?? "asdasd",
                style: containerSpan.style);
          }
        }
      }
    }

    return "";
  }
}
