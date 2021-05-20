import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/objects/dto_header.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/widgets/input/inputfield_quill.dart';

class PageHeader extends StatefulWidget {
  PageHeader(
      {Key? key, this.content, required this.isDisable, this.onNextFocus})
      : super(key: key);

  final DTOHeader? content;
  final bool isDisable;
  final ValueChanged<FocusNode>? onNextFocus;
  final List<InputfieldQuill> inputFields = List.empty(growable: true);

  @override
  PageHeaderState createState() => PageHeaderState();
}

class PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    double height = UtilSize.getHeaderHeigth(context);

    EdgeInsets getPadding() {
      double width = UtilSize.getPageWidth(context);
      double paddingTLR = paperMarginTLRRelative * width;
      return EdgeInsets.only(
          left: paddingTLR, right: paddingTLR, top: paddingTLR);
    }

    return Container(
        padding: getPadding(),
        margin: EdgeInsets.only(bottom: 10),
        height: height + (widget.isDisable ? 10 : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: widget.isDisable ? highlightColor : Colors.transparent,
              width: 6,
              style: BorderStyle.solid),
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
              "body": Style(
                margin: EdgeInsets.all(0),
              ),
              // <-- remove the margin
              //  "p": Style(  width: 200)
            },
            customRender: getCustomRenderer(),
            data: widget.content?.content ?? ""));
  }

  getCustomRenderer() {
    return {
      "b": (RenderContext context, Widget child) {
        return generateInputField(child);
      },
      "i": (RenderContext context, Widget child) {
        return generateInputField(child);
      },
      "span": (RenderContext context, Widget child) {
        Map attributes = context.tree.element?.attributes ?? Map();
        String? content;
        if (attributes["content"] != null) {
          content = attributes["content"];
        }

        return generateInputField(child, contentDescription: content);
      },
      "div": (RenderContext context, Widget child) {
        Map attributes = context.tree.element?.attributes ?? Map();
        if (attributes["orientation"] != null &&
            attributes["orientation"] == "right") {
          return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IntrinsicWidth(child: child),
            ],
          ));
        } else
          return child;
      },
    };
  }

  generateInputField(Widget child, {String? contentDescription}) {
    if (child is ContainerSpan?) {
      ContainerSpan? containerSpan = child as ContainerSpan?;
      if (containerSpan != null && containerSpan.children != null) {
        List<InlineSpan> children = containerSpan.children!;

        for (var value in children) {
          if (value is TextSpan) {
            //  FocusNode focusNode = FocusNode(debugLabel: value.text);
            //  if (widget.inputFields.length == 0 && !widget.isDisable) {
            //    focusNode.requestFocus();
            // }

            String txt = value.text ?? "";
            List<String> paragraphs = txt.split("\\n");
            StringBuffer sb = new StringBuffer();
            for (String line in paragraphs) {
              if (line.isNotEmpty) {
                sb.write(line.trim() + "\n");
              }
            }
            String finalText = sb.toString();

            InputfieldQuill inputfieldQuill = InputfieldQuill(
              contentDescription: contentDescription,
              key: GlobalKey<InputfieldQuillState>(),
              initialContent: finalText,
              style: containerSpan.style,
              readOnly: widget.isDisable,
            );
            widget.inputFields.add(inputfieldQuill);

            return inputfieldQuill;
          }
        }
      }
    }

    return "";
  }

  void changeHeaderContent(String type, Map<String,String> text) {
    for (InputfieldQuill value in widget.inputFields) {
      (value.key as GlobalKey<InputfieldQuillState>)
          .currentState
          ?.changeHeaderContent(type, text);
    }
  }
}
