import 'package:flutter/material.dart';
import 'package:sire/widgets/editor/page_combined.dart';

class PageData extends StatefulWidget {
  PageData(
      {Key? key,
      required this.header,
      required this.body,
      required this.footer})
      : super(key: key);
  final PageCombined? header, body, footer;

  @override
  PageDataState createState() => PageDataState();
}

class PageDataState extends State<PageData> {
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.header?.isDisable.value=false;
      widget.body?.isDisable.value=false;
      widget.footer?.isDisable.value=false;
    });

    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 20,fit: FlexFit.tight, child: widget.header??Container()),
            Flexible(flex: 70,fit: FlexFit.tight, child: widget.body??Container()),
            Flexible(flex: 10,fit: FlexFit.tight, child: widget.footer??Container()),
          ],
        ));
  }
}
