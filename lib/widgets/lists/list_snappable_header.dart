import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/page/page_header.dart';

class ListSnappableHeader extends StatefulWidget {
  ListSnappableHeader(
      {Key? key, required this.onFocused, required this.contentPages})
      : super(key: key);

  final ValueChanged<int> onFocused;
  final List<PageHeader> contentPages;
  final GlobalKey<ScrollSnapListState> snaplistKey = GlobalKey();

  @override
  ListSnappableHeaderState createState() => ListSnappableHeaderState();
}

class ListSnappableHeaderState extends State<ListSnappableHeader> {
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
    selectedIndex = 0;
    return Container(
        width: widthPage,
        child: ListView.builder(
          //  key:widget.snaplistKey,
          scrollDirection: Axis.vertical,
          //scrollPhysics: PageScrollPhysics(),
          itemCount: widget.contentPages.length,
          controller: _scrollController,
          // initialIndex: 0,
          //selectedItemAnchor: SelectedItemAnchor.START,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  ViewModelMain viewModelMain = Get.put(ViewModelMain());
                  viewModelMain.currentHeader.value = index;
                  selectedIndex = index;
                for(int i=0; i<widget.contentPages.length;i++){

                  widget.contentPages[i].highlight(i==index);

                }


                },
                child: widget.contentPages[index]);
          },
          //   endOfListTolerance: 100,

          //  margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          //onItemFocus: (int) {
          //widget.onFocused(int);
          // selectedIndex = int;
          //},
          //itemSize: UtilSize.getHeaderMinHeigth(context),
        ));
  }

  void reset() {
    // int selectedIndex = ((widget.content?.length ?? 0) / 2).floor();
    //  widget.snaplistKey.currentState?.focusToItem(selectedIndex);
  }
}
