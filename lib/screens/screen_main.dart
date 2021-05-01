import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/objects/dto_header.dart';
import 'package:sire/utils/util_server.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_go.dart';
import 'package:sire/widgets/buttons/button_scale.dart';
import 'package:sire/widgets/containers/container_editing.dart';
import 'package:sire/widgets/containers/container_final.dart';
import 'package:sire/widgets/containers/container_header.dart';
import 'package:sire/widgets/containers/container_welcome.dart';
import 'package:sire/widgets/logos/logo_sire_small.dart';

import 'package:sire/widgets/page/interactive_page.dart';
import 'package:sire/widgets/logos/logo_createdby.dart';
import 'package:sire/widgets/logos/logo_sire.dart';
import 'package:sire/widgets/misc/arrow_default.dart';
import 'package:sire/widgets/switchs/switcher_darkmode.dart';

enum ShowingContainer { Welcome, HeaderSelection, EditingTool, Final }

class ScreenMain extends StatefulWidget {
  GlobalKey<InteractivePageState> pageKey = GlobalKey();

  ScreenMain({Key? key}) : super(key: key) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.interactivePageKey = pageKey;
  }

  @override
  _ScreenMainState createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> with TickerProviderStateMixin {
  RxBool _appLoaded = false.obs;

  @override
  Widget build(BuildContext context) {
    double widthViewer = MediaQuery.of(context).size.width * viewerWidth;
    double widthPage = min(
        MediaQuery.of(context).size.height * heightPercentage,
        widthViewer * 0.9);
    double topOffsetPage = MediaQuery.of(context).size.height / 5;
    double diffPageViewer = widthViewer - widthPage;

    double widthContainer =
        (1 - viewerWidth) * MediaQuery.of(context).size.width;
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
                  key: widget.pageKey,
                ),
                Align(
                  child: Container(
                      margin: EdgeInsets.all(10), child: ButtonScale()),
                  alignment: Alignment.bottomLeft,
                ),
                Align(
                  child: Container(
                      margin: EdgeInsets.all(20), child: LogoSireSmall()),
                  alignment: Alignment.topLeft,
                ),
                Obx(() => Positioned(
                      top: getTopOffsetForShowingContainer(topOffsetPage),
                      height:
                          MediaQuery.of(context).size.height - getTopOffsetForShowingContainer(topOffsetPage),
                      width: widthContainer + diffPageViewer / 2 - 80,
                      child: getShowingContainer(),
                      left: widthViewer - diffPageViewer / 2 + 40,
                    )),
                Align(
                    child: Container(
                        margin: EdgeInsets.all(10), child: SwitcherDarkmode()),
                    alignment: Alignment.topRight),
                Positioned(
                  child: Obx(() => AnimatedOpacity(
                      opacity: viewModelMain.editingStarted.value ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        child: SizedBox(
                            width: widthPage,
                            child: QuillToolbar.basic(
                              controller: viewModelMain.currentController.value,
                            )),
                      ))),
                  top: 50,
                  left: diffPageViewer / 2,
                ),
                Positioned(
                    child: IgnorePointer(
                        child: Obx(() => AnimatedOpacity(
                            opacity: viewModelMain.editingStarted.value ? 0 : 1,
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
                    color: navigationBarBackgroundColor,
                    size: 30.0,
                  ))))))
    ]);
  }

  Widget getShowingContainer() {
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

  double getTopOffsetForShowingContainer(double topOffsetPage) {
    ViewModelMain vm = Get.put(ViewModelMain());
    switch (vm.currentContainer.value) {
      case ShowingContainer.HeaderSelection:
        return topOffsetPage - 50;
    }
    return topOffsetPage;
  }
}
