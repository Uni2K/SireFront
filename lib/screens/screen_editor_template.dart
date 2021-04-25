import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/helper_server.dart';
import 'package:sire/utils/linked_scroll_controller.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/editor/page_editing.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class ScreenEditorTemplate extends StatefulWidget {
  ScreenEditorTemplate({Key? key}) : super(key: key);

  GlobalKey<PageEditingState> previewBackground = GlobalKey();
  GlobalKey editingKey = GlobalKey();
  GlobalKey backgroundKey = GlobalKey();
  GlobalKey contentKey = GlobalKey();

  GlobalKey<ListSnappableCombinedState> footerKey = GlobalKey(),
      bodyKey = GlobalKey(),
      headerKey = GlobalKey(),
      footerBKey = GlobalKey(),
      bodyBKey = GlobalKey(),
      headerBKey = GlobalKey();

  @override
  ScreenEditorTemplateState createState() => ScreenEditorTemplateState();
}

class ScreenEditorTemplateState extends State<ScreenEditorTemplate> with TickerProviderStateMixin {
  LinkedScrollControllerGroup? _controllersHeader,
      _controllersBody,
      _controllersFooter;

  ScrollController? _headerContent, _bodyContent, _footerContent;
  ScrollController? _headerBackground, _bodyBackground, _footerBackground;

  @override
  void dispose() {
    print("dispose");
    _headerContent?.dispose();
    _headerBackground?.dispose();

    _bodyBackground?.dispose();
    _bodyContent?.dispose();

    _footerBackground?.dispose();
    _footerContent?.dispose();
    print("dispose end");

    super.dispose();
  }

  @override
  void initState() {
    print("init");

    super.initState();
    _controllersHeader = LinkedScrollControllerGroup();
    _controllersBody = LinkedScrollControllerGroup();
    _controllersFooter = LinkedScrollControllerGroup();

    _headerContent = _controllersHeader?.addAndGet();
    _headerBackground = _controllersHeader?.addAndGet();

    _bodyContent = _controllersBody?.addAndGet();
    _bodyBackground = _controllersBody?.addAndGet();

    _footerContent = _controllersFooter?.addAndGet();
    _footerBackground = _controllersFooter?.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    print("build");
    return Query(
        options: QueryOptions(
          document: gql(HelperServer.getAllContent()),
          pollInterval: Duration(seconds: 60),
          cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return SizedBox();
          }

          return Obx(() => AnimatedOpacity(
              opacity: viewModelMain.appLoaded.value ? 1 : 0,
              duration: Duration(milliseconds: 1000),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height * heightPercentage,
                    child: Stack(
                      children: [
                        Align(
                            key: widget.backgroundKey,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    flex: 20,
                                    child: ListSnappableCombined(
                                        result: result,
                                        scrollController: _headerBackground,
                                        key: widget.headerBKey,
                                        onFocused: () => highlightAnimation(0),
                                        contentType: ContentTypes.Header,
                                        background: true)),
                                Flexible(
                                    flex: 70,
                                    child: ListSnappableCombined(
                                        onFocused: () => highlightAnimation(1),
                                        result: result,
                                        scrollController: _bodyBackground,
                                        key: widget.bodyBKey,
                                        contentType: ContentTypes.Body,
                                        background: true)),
                                Flexible(
                                    flex: 10,
                                    child: ListSnappableCombined(
                                        onFocused: () => highlightAnimation(2),
                                        result: result,
                                        scrollController: _footerBackground,
                                        key: widget.footerBKey,
                                        contentType: ContentTypes.Footer,
                                        background: true)),
                              ],
                            )),
                        Align(
                          child: RepaintBoundary(
                              key: widget.editingKey,
                              child: PageEditing(
                                key: widget.previewBackground,
                              )),
                          alignment: Alignment.center,
                        ),
                        Align(
                            key: widget.contentKey,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    flex: 20,
                                    child: ListSnappableCombined(
                                      onFocused: () => null,
                                      result: result,
                                      key: widget.headerKey,
                                      scrollController: _headerContent,
                                      contentType: ContentTypes.Header,
                                    )),
                                Flexible(
                                    flex: 70,
                                    child: ListSnappableCombined(
                                      onFocused: () => null,
                                      result: result,
                                      key: widget.bodyKey,
                                      scrollController: _bodyContent,
                                      contentType: ContentTypes.Body,
                                    )),
                                Flexible(
                                    flex: 10,
                                    child: ListSnappableCombined(
                                        onFocused: () => null,
                                        result: result,
                                        key: widget.footerKey,
                                        scrollController: _footerContent,
                                        contentType: ContentTypes.Footer)),
                              ],
                            )),
                        // ...buildNavigationOverlay(context),
                      ],
                    ),
                  ))));
        });
  }

  highlightAnimation(int i) {
    Timer(Duration(seconds: 1), () {
      widget.previewBackground.currentState?.highlightAnimation(i);
    });
  }

  void save() {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.footer = widget.footerKey.currentState?.getContent();
    viewModelMain.header = widget.headerKey.currentState?.getContent();
    viewModelMain.body = widget.bodyKey.currentState?.getContent();




  }

  reset() {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    widget.bodyKey.currentState?.reset();
    widget.headerKey.currentState?.reset();
    widget.footerKey.currentState?.reset();

    widget.bodyBKey.currentState?.reset();
    widget.headerBKey.currentState?.reset();
    widget.footerBKey.currentState?.reset();

    viewModelMain.footer = null;
    viewModelMain.header = null;
    viewModelMain.body = null;
  }
}
