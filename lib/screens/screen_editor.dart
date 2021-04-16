import 'dart:async';
import 'dart:math';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:printing/printing.dart';
import 'package:sire/bars/navigation/bar_steps.dart';
import 'package:sire/bars/navigation/logo.dart';
import 'package:sire/bars/navigation/type_selector.dart';
import 'package:sire/bars/saving/bar_editing.dart';
import 'package:sire/bars/saving/preview.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/helper_server.dart';
import 'package:sire/screens/screen_preview.dart';
import 'package:sire/widgets/editor/page_editing.dart';
import 'package:sire/widgets/editor/page_preview.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';
import 'package:sire/widgets/overlay/navigation_round.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ScreenEditor extends StatefulWidget {
  ScreenEditor({Key? key}) : super(key: key);

  GlobalKey editingKey = GlobalKey();
  GlobalKey backgroundKey = GlobalKey();
  GlobalKey contentKey = GlobalKey();
  GlobalKey<ScreenPreviewState> screenPreviewKey = new GlobalKey();

  @override
  _ScreenEditorState createState() => _ScreenEditorState();
}

class _ScreenEditorState extends State<ScreenEditor>
    with TickerProviderStateMixin {
  LinkedScrollControllerGroup? _controllersHeader,
      _controllersBody,
      _controllersFooter;

  ScrollController? _headerContent, _bodyContent, _footerContent;
  ScrollController? _headerBackground, _bodyBackground, _footerBackground;

  GlobalKey<PageEditingState> previewBackground=GlobalKey();

  GlobalKey<ListSnappableCombinedState> footerKey = GlobalKey(),
      bodyKey = GlobalKey(),
      headerKey = GlobalKey(),
      footerBKey = GlobalKey(),
      bodyBKey = GlobalKey(),
      headerBKey = GlobalKey();

  late AnimationController previewController;
  late Animation<double> previewAnimation;

  RxBool isLoadingFinished = false.obs;
  bool isLoadingInProgress = true;

  @override
  void initState() {
    super.initState();
    createScrollControllers();

    previewController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    previewAnimation = CurvedAnimation(
      parent: previewController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    disposeScrollControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      showApp();
    });

    return Material(
        color: backgroundColor,
        child: Stack(
          children: [
            Query(
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
                  if (result.isLoading ) {
                    return SizedBox();
                  }
                  isLoadingInProgress = false;

                  return Obx(() => AnimatedOpacity(
                      opacity: isLoadingFinished.value ? 1 : 0,
                      duration: Duration(milliseconds: 1000),
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                heightPercentage,
                            child: Stack(
                              children: [
                                Align(
                                    key: widget.backgroundKey,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 20,
                                            child: ListSnappableCombined(
                                                result: result,
                                                scrollController:
                                                    _headerBackground,
                                                key: headerBKey,
                                                onFocused: ()=>highlightAnimation(0),
                                                contentType:
                                                    ContentTypes.Header,
                                                background: true)),
                                        Flexible(
                                            flex: 70,
                                            child: ListSnappableCombined(
                                                onFocused: ()=>highlightAnimation(1),
                                                result: result,
                                                scrollController:
                                                    _bodyBackground,
                                                key: bodyBKey,
                                                contentType: ContentTypes.Body,
                                                background: true)),
                                        Flexible(
                                            flex: 10,
                                            child: ListSnappableCombined(
                                                onFocused: ()=>highlightAnimation(2),
                                                result: result,
                                                scrollController:
                                                    _footerBackground,
                                                key: footerBKey,
                                                contentType:
                                                    ContentTypes.Footer,
                                                background: true)),
                                      ],
                                    )),
                                Align(
                                  child: RepaintBoundary(
                                      key: widget.editingKey,
                                      child: PageEditing(key: previewBackground,)),
                                  alignment: Alignment.center,
                                ),
                                Align(
                                    key: widget.contentKey,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 20,
                                            child: ListSnappableCombined(
                                              onFocused: ()=>null,
                                              result: result,
                                              key: headerKey,
                                              scrollController: _headerContent,
                                              contentType: ContentTypes.Header,
                                            )),
                                        Flexible(
                                            flex: 70,
                                            child: ListSnappableCombined(
                                              onFocused: ()=>null,
                                              result: result,
                                              key: bodyKey,
                                              scrollController: _bodyContent,
                                              contentType: ContentTypes.Body,
                                            )),
                                        Flexible(
                                            flex: 10,
                                            child: ListSnappableCombined(
                                                onFocused: ()=>null,
                                                result: result,
                                                key: footerKey,
                                                scrollController:
                                                    _footerContent,
                                                contentType:
                                                    ContentTypes.Footer)),
                                      ],
                                    )),
                                ...buildNavigationOverlay(context),
                              ],
                            ),
                          ))));
                }),
            Obx(() => AnimatedOpacity(
                opacity: isLoadingFinished.value ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: Center(
                        child:  SpinKitFadingCube(
                        color: navigationBarBackgroundColor,
                        size: 30.0,
                        )
                       ))),
            CircularRevealAnimation(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: previewBackgroundColor,
                child: ScreenPreview(
                  key: widget.screenPreviewKey,
                  bodyKey: bodyKey,
                  footerKey: footerKey,
                  headerKey: headerKey,
                ),
                alignment: Alignment.center,
              ),
              animation: previewAnimation,
              centerAlignment: Alignment.bottomCenter,
            ),
            Align(
              child: Logo(),
              alignment: Alignment.topLeft,
            ),
            Align(
              child: BarSteps(),
              alignment: Alignment.topCenter,
            ),
            Obx(() => AnimatedOpacity(
                  opacity: isLoadingFinished.value ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: Align(
                    child: Container(
                        width: (MediaQuery.of(context).size.height *
                                heightPercentage) /
                            sqrt(2),
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          children: [
                            BarEditing(
                              delete: () => delete(),
                              help: () => openHelp(),
                            ),
                            Spacer(),
                            Preview(onClick: () => openPreview())
                          ],
                        )),
                    alignment: Alignment.bottomCenter,
                  ),
                ))
          ],
        ));
  }

  getVerticalDivider() {
    return SizedBox(
      height: 5,
    );
  }

  List<Widget> buildNavigationOverlay(BuildContext context) {
    List<Widget> overlayWidgets = List.empty(growable: true);
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    double buttonSize = 30;

    double topHeaderMid = totalHeight * heightPercentage * 0.1;
    double leftNavLeft =
        (totalWidth / 2.0) - ((totalHeight * heightPercentage / sqrt(2)) / 2);
    double leftNavRight =
        (totalWidth / 2.0) + ((totalHeight * heightPercentage / sqrt(2)) / 2);

    Positioned leftNav = Positioned(
      child: NavigationRound(
        back: true,
        onClick: () => navigatePrevious(ContentTypes.Header, context),
      ),
      top: topHeaderMid - buttonSize / 2,
      left: leftNavLeft - buttonSize / 2,
    );
    Positioned rightNav = Positioned(
      child: NavigationRound(
        onClick: () => navigateNext(ContentTypes.Header, context),
      ),
      top: topHeaderMid - buttonSize / 2,
      left: leftNavRight - buttonSize / 2,
    );

    overlayWidgets.add(leftNav);
    overlayWidgets.add(rightNav);

    return overlayWidgets;
  }

  navigatePrevious(ContentTypes header, BuildContext context) {
    _controllersHeader?.animateTo(0,
        curve: Curves.linear, duration: Duration(seconds: 1));
  }

  navigateNext(ContentTypes header, BuildContext context) {
    _controllersHeader?.animateTo(30,
        curve: Curves.linear, duration: Duration(seconds: 1));
  }


  openPreview() {
    widget.screenPreviewKey.currentState!.setState(() {});
    if (previewController.status == AnimationStatus.forward ||
        previewController.status == AnimationStatus.completed) {
      previewController.reverse();
    } else {
      previewController.forward();
    }
  }

  showApp() {
    if (!isLoadingInProgress) isLoadingFinished.value = true;
  }

  openHelp() {}

  delete() {}

  void createScrollControllers() {
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

  void disposeScrollControllers() {
     _headerContent?.dispose();
    _headerBackground?.dispose();

    _bodyBackground?.dispose();
    _bodyContent?.dispose();

    _footerBackground?.dispose();
    _footerContent?.dispose();

  }

  highlightAnimation(int i) {
    Timer(Duration(seconds: 1), () {
      previewBackground.currentState?.highlightAnimation(i);

    });

  }
}
