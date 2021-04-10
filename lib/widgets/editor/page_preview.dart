import 'package:flutter/material.dart';
import 'package:sire/widgets/editor/page_combined.dart';

class PagePreview extends StatefulWidget {
  PagePreview(
      {Key? key,
      required this.header,
      required this.body,
      required this.footer})
      : super(key: key);

  final PageCombined? header, body, footer;

  @override
  PagePreviewState createState() => PagePreviewState();
}

class PagePreviewState extends State<PagePreview> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 20,fit: FlexFit.tight, child: widget.header??Container(color: Colors.red,)),
            Flexible(flex: 70,fit: FlexFit.tight, child: widget.body??Container()),
            Flexible(flex: 10,fit: FlexFit.tight, child: widget.footer??Container()),
          ],
        ));
  }
}
