import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_server.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_scale.dart';
import 'package:sire/widgets/containers/container_editing.dart';
import 'package:sire/widgets/containers/container_final.dart';
import 'package:sire/widgets/containers/container_header.dart';
import 'package:sire/widgets/containers/container_welcome.dart';
import 'package:sire/widgets/logos/logo_sire_small.dart';
import 'package:sire/widgets/page/interactive_page.dart';
import 'package:sire/widgets/misc/arrow_default.dart';
import 'package:sire/widgets/page/page_prototype.dart';
import 'package:sire/widgets/switchs/switcher_darkmode.dart';

enum ShowingContainer { Welcome, HeaderSelection, EditingTool, Final }

class ScreenMain extends StatefulWidget {
  final GlobalKey<InteractivePageState> interactiveViewerKey = GlobalKey();
  final GlobalKey<PagePrototypeState> pagePrototypeKey = GlobalKey();

  ScreenMain({Key? key}) : super(key: key) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.interactivePageKey = interactiveViewerKey;
    viewModelMain.pagePrototypeKey = pagePrototypeKey;
  }

  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> with TickerProviderStateMixin {
  RxBool _appLoaded = false.obs;
  ViewModelMain vm = Get.put(ViewModelMain());

  @override
  Widget build(BuildContext context) {
    double widthViewer = UtilSize.getViewerWidth(context);
    double widthPage = UtilSize.getPageWidth(context);
    double topOffsetPage = UtilSize.getPageOffsetTop(context);
    double diffPageViewer = widthViewer - widthPage;
    double leftContainer = UtilSize.getContainerLeft(context);
    double topToolBar = UtilSize.getToolbarTop(context);

    return Stack(children: [
      Query(
          options: QueryOptions(
            document: gql(UtilServer.getInitialContent()),
            pollInterval: null,
            cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
            fetchPolicy: FetchPolicy.cacheAndNetwork,
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              print(result.exception?.linkException.toString());
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return SizedBox();
            }
            ViewModelMain viewModelMain = Get.put(ViewModelMain());
            viewModelMain.setServerContent(result.data);
            Timer(Duration(milliseconds: 500), () {
              _appLoaded.value = true;
            });

            return Scaffold(
                body: Stack(
              children: [
                InteractivePage(
                  key: widget.interactiveViewerKey,
                  pageKey: widget.pagePrototypeKey,
                ),
                Align(
                  child: Container(
                      margin: EdgeInsets.all(10), child: ButtonScale()),
                  alignment: Alignment.bottomLeft,
                ),
                Align(
                  child: Obx(() => AnimatedOpacity(
                      opacity: viewModelMain.currentContainer.value ==
                              ShowingContainer.Welcome
                          ? 0
                          : 1,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                          margin: EdgeInsets.all(20), child: LogoSireSmall()))),
                  alignment: Alignment.topLeft,
                ),
                Obx(() {
                  double offsetTopContainer =
                      UtilSize.getTopOffsetForShowingContainer(
                          context, vm.currentContainer.value);

                  return Positioned(
                      top: offsetTopContainer,
                      height: MediaQuery.of(context).size.height -
                          offsetTopContainer,
                      width: widthPage,
                      //widthContainer + diffPageViewer / 2 - 80,
                      child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          child: _getShowingContainer()),
                      left: leftContainer //+ 40,
                      );
                }),
                Align(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ButtonCircleNeutral(
                                icon: Icon(
                                  Icons.info,
                                  color: switchOnColor,
                                  size: 21,
                                ),
                                onClick: () => null),
                            SizedBox(
                              width: 5,
                            ),
                            SwitcherDarkmode()
                          ],
                        )),
                    alignment: Alignment.topRight),
                Positioned(
                  child: Obx(() => AnimatedOpacity(
                      opacity: _isToolbarVisible() ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        child: SizedBox(
                            width: widthPage,
                            child: QuillToolbar.basic(
                              showListCheck: false,
                              controller: viewModelMain.currentController.value,
                            )),
                      ))),
                  top: topToolBar,
                  left: diffPageViewer / 2,
                ),
                Positioned(
                    child: IgnorePointer(
                        child: Obx(() => AnimatedOpacity(
                            opacity: viewModelMain.currentContainer.value ==
                                    ShowingContainer.Welcome
                                ? 1
                                : 0,
                            duration: Duration(milliseconds: 500),
                            child: ArrowDefault()))),
                    top: topOffsetPage / 2 + 20,
                    left: (widthViewer - widthPage) / 2 - 40)
              ],
            ));
          }),
      IgnorePointer(
          child: Obx(() => AnimatedOpacity(
              opacity: _appLoaded.value ? 0 : 1,
              duration: Duration(milliseconds: 500),
              child: Container(
                  color: Colors.white,
                  child: Center(
                      child: SpinKitFadingCube(
                    color: primaryColor,
                    size: 30.0,
                  ))))))
    ]);
  }

  Widget _getShowingContainer() {
    ViewModelMain vm = Get.put(ViewModelMain());
    switch (vm.currentContainer.value) {
      case ShowingContainer.Welcome:
        return ContainerWelcome();
      case ShowingContainer.HeaderSelection:
        return ContainerHeader();
      case ShowingContainer.Final:
        return ContainerFinal();
      case ShowingContainer.EditingTool:
        return ContainerEditing();
    }
  }

  bool _isToolbarVisible() {
    ViewModelMain vm = Get.put(ViewModelMain());
    if (vm.isCurrentlyTouched.value) return false;
    return vm.currentContainer.value == ShowingContainer.HeaderSelection ||
        vm.currentContainer.value == ShowingContainer.EditingTool;
  }
}
