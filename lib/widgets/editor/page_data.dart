import 'package:flutter/material.dart';
import 'package:sire/objects/page_constituent.dart';
import 'package:sire/widgets/editor/page_combined.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class PageData extends StatefulWidget {
  PageData(
      {Key? key,
      required this.header,
      required this.body,
      required this.footer})
      : super(key: key);
  final PageConstituent? header, body, footer;

  GlobalKey<PageCombinedState> footerKey=GlobalKey();
  GlobalKey<PageCombinedState> headerKey=GlobalKey();
  GlobalKey<PageCombinedState> bodyKey=GlobalKey();


  @override
  PageDataState createState() => PageDataState();
}

class PageDataState extends State<PageData> {
  List<FocusNode> focusNodes = List.empty(growable: true);



  updateFocusNodes() {
    List<FocusNode>? focusNodesFooter = widget.footerKey.currentState?.getFocusNodes();
    List<FocusNode>? focusNodesBody =  widget.bodyKey.currentState?.getFocusNodes();
    List<FocusNode>? focusNodesHeader =  widget.headerKey.currentState?.getFocusNodes();
    List<FocusNode> combinedFocusNodes = {
      ...?focusNodesHeader,
      ...?focusNodesBody,
      ...?focusNodesFooter
    }.toList();
    focusNodes = combinedFocusNodes;
  }

  nextFocus(FocusNode focusNode) {
    updateFocusNodes();
    int index = focusNodes.indexOf(focusNode);
    if (focusNodes.length > index + 1) {
      FocusNode nextFocusNode = focusNodes[index + 1];
      nextFocusNode.requestFocus();
    }
  }


  @override
  Widget build(BuildContext context) {


    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 20,
                fit: FlexFit.tight,
                child: PageCombined(
                  key:  widget.headerKey,
                  content: widget.header?.content,
                  contentType: ContentTypes.Header,
                  isDisable: false,
                  onNextFocus: (_)=>nextFocus(_),
                  background: false,
                )),
            Flexible(
                flex: 70,
                fit: FlexFit.tight,
                child: PageCombined(
                  key:  widget.bodyKey,
                  content: widget.body?.content,
                  contentType: ContentTypes.Body,
                  isDisable: false,
                  background: false,
                  onNextFocus: (_)=>nextFocus(_),
                )),
            Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: PageCombined(
                  key:  widget.footerKey,
                  content: widget.footer?.content,
                  contentType: ContentTypes.Footer,
                  isDisable: false,
                  onNextFocus: (_)=>nextFocus(_),
                  background: false,
                )),
          ],
        ));
  }
}
