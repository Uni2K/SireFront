import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/page/page_header.dart';

class ListSnappableCombined extends StatefulWidget {
  ListSnappableCombined(
      {Key? key, required this.onFocused, required this.contentPages})
      : super(key: key);

  final ValueChanged<int> onFocused;
  final List<PageHeader> contentPages;
  final GlobalKey<ScrollSnapListState> snaplistKey = GlobalKey();

  @override
  ListSnappableCombinedState createState() => ListSnappableCombinedState();
}

class ListSnappableCombinedState extends State<ListSnappableCombined> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  late ScrollController? _scrollController; //disposed by widget

  @override
  Widget build(BuildContext context) {
    double widthPage = UtilSize.getPageWidth(context);
    double height = UtilSize.getHeaderHeigth(context);
    selectedIndex = 0;
    return Container(
        width: widthPage,
        child: ScrollSnapList(
          //  key:widget.snaplistKey,
          scrollDirection: Axis.vertical,
          itemCount: widget.contentPages.length,
          listController: _scrollController,
          initialIndex: 0,
          selectedItemAnchor: SelectedItemAnchor.START,
          itemSize: height,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  ViewModelMain viewModelMain = Get.put(ViewModelMain());
                  viewModelMain.currentHeader.value =
                      viewModelMain.headerCached.elementAt(index);
                },
                child: widget.contentPages[index]);
          },
          endOfListTolerance: 100,
          updateOnScroll: false,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          onItemFocus: (int) {
            widget.onFocused(int);
            selectedIndex = int;
          },
        ));
  }

  void reset() {
    // int selectedIndex = ((widget.content?.length ?? 0) / 2).floor();
    //  widget.snaplistKey.currentState?.focusToItem(selectedIndex);
  }
}
