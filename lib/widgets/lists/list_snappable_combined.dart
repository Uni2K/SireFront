import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/helper_server.dart';
import 'package:sire/objects/page_constituent.dart';
import 'package:sire/widgets/editor/page_combined.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

enum ContentTypes { Header, Body, Footer }

class ListSnappableCombined extends StatefulWidget {
  ListSnappableCombined({Key? key,
    this.scrollController,
    required this.contentType,
    this.background = false,
    required QueryResult result,
    required this.onFocused})
      : super(key: key) {
    content = result.data ? [getDataSelector()];
    for (var item in content ?? []) {
      contentPages.add(PageCombined(
        isDisable: true,
        content: item["content"],
        background: background,
        contentType: contentType,
      ));
    }
  }

  final VoidCallback onFocused;
  final ContentTypes contentType;
  final ScrollController? scrollController;
  final bool background;
  List? content;
  int selectedIndex = -1;
  List<PageCombined> contentPages = List.empty(growable: true);

  GlobalKey<ScrollSnapListState> snaplistKey=GlobalKey();


  getDataSelector() {
    switch (contentType) {
      case ContentTypes.Header:
        return "headers";
      case ContentTypes.Body:
        return "bodies";
      case ContentTypes.Footer:
        return "footers";
    }
  }

  @override
  ListSnappableCombinedState createState() => ListSnappableCombinedState();
}

class ListSnappableCombinedState extends State<ListSnappableCombined> {


  @override
  Widget build(BuildContext context) {
    widget.selectedIndex = ((widget.content?.length ?? 0) / 2).floor();
    return ScrollSnapList(
      key:widget.snaplistKey,
      scrollDirection: Axis.horizontal,
      itemCount: widget.content?.length,
      listController: widget.scrollController,
      initialIndex: ((widget.content?.length ?? 0) / 2).floor().roundToDouble(),
      itemBuilder: (context, index) {
        return widget.contentPages[index];
      },
      itemSize:
      (((MediaQuery
          .of(context)
          .size
          .height * heightPercentage) / sqrt(2))),
      updateOnScroll: true,
      onItemFocus: (int) {
        widget.onFocused();
        widget.selectedIndex = int;
        },
    );
  }


  PageConstituent? getContent() {
    if (widget.background) return null;
    if (widget.content != null) {
      return widget.contentPages[widget.selectedIndex].getPageConstituent();
    }
  }

  void reset() {
    int selectedIndex = ((widget.content?.length ?? 0) / 2).floor();
    widget.snaplistKey.currentState?.focusToItem(selectedIndex);

  }
}
