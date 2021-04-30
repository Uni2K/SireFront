import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sire/widgets/page/page_header.dart';


class ListSnappableCombined extends StatefulWidget {
  ListSnappableCombined({Key? key,
    required QueryResult result,
    required this.onFocused})
      : super(key: key) {
    for (var item in result.data!["headers"] ?? []) {
      contentPages.add(PageHeader(
        isDisable: true,
        content: item["content"],
      ));
    }
  }

  final VoidCallback onFocused;
  List? content;
  int selectedIndex = -1;
  List<PageHeader> contentPages = List.empty(growable: true);

  GlobalKey<ScrollSnapListState> snaplistKey=GlobalKey();


  @override
  ListSnappableCombinedState createState() => ListSnappableCombinedState();
}

class ListSnappableCombinedState extends State<ListSnappableCombined> {

  @override
  void initState() {
    _scrollController=ScrollController();
    super.initState();
  }


  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();

  }
  late ScrollController? _scrollController;




  @override
  Widget build(BuildContext context) {
    double widthViewer = MediaQuery.of(context).size.width * viewerWidth;
    double widthPage = min(
        MediaQuery.of(context).size.height * heightPercentage,
        widthViewer * 0.9);
    double height = widthPage * sqrt(2) * headerPercentage*0.2;
    widget.selectedIndex = 0;
    return Container(
        width: widthPage,
        child:ScrollSnapList(
    //  key:widget.snaplistKey,
      scrollDirection: Axis.vertical,
      itemCount: widget.contentPages.length,
      listController: _scrollController,
      initialIndex: 0,
      selectedItemAnchor: SelectedItemAnchor.START,
      itemSize: height,
      itemBuilder: (context, index) {
        return widget.contentPages[index];
      },
      updateOnScroll: false,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      onItemFocus: (int) {
        print("focues on:$int ");
        widget.onFocused();
        widget.selectedIndex = int;
        },
    ));
  }




  void reset() {
   // int selectedIndex = ((widget.content?.length ?? 0) / 2).floor();
  //  widget.snaplistKey.currentState?.focusToItem(selectedIndex);

  }
}
