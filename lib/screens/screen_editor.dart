import 'dart:async';
import 'dart:math';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/bars/editor/bar_tools_editor.dart';
import 'package:sire/bars/navigation/bar_steps.dart';
import 'package:sire/bars/navigation/logo.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/helper_server.dart';
import 'package:sire/screens/screen_editor_data.dart';
import 'package:sire/screens/screen_editor_result.dart';
import 'package:sire/screens/screen_editor_template.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_navigation.dart';
import 'package:flutter/rendering.dart';

class ScreenEditor extends StatefulWidget {
  ScreenEditor({Key? key}) : super(key: key);

  GlobalKey<ScreenEditorDataState> screenEditorDataKey = new GlobalKey();
  GlobalKey<ScreenEditorResultState> screenEditorResultKey = new GlobalKey();
  GlobalKey<ScreenEditorTemplateState> screenEditorTemplateKey =
      new GlobalKey();

  @override
  _ScreenEditorState createState() => _ScreenEditorState();
}

class _ScreenEditorState extends State<ScreenEditor>
    with TickerProviderStateMixin {
  late AnimationController dataScreenController;
  late Animation<double> dataScreenAnimation;
  late AnimationController resultScreenController;
  late Animation<double> resultScreenAnimation;

  @override
  void initState() {
    super.initState();
    dataScreenController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    dataScreenAnimation = CurvedAnimation(
      parent: dataScreenController,
      curve: Curves.easeIn,
    );

    resultScreenController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    resultScreenAnimation = CurvedAnimation(
      parent: resultScreenController,
      curve: Curves.easeIn,
    );
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    ever(viewModelMain.currentEditorStep, (val) {
      switch (val) {
        case EditorSteps.Template:
          showTemplateScreen();
          break;
        case EditorSteps.Data:
          showDataScreen();
          break;
        case EditorSteps.Result:
          showResultScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    Timer(Duration(seconds: 2), () {
      viewModelMain.appLoaded.value = true;
    });

    return Material(
        color: backgroundColor,
        child: Stack(
          children: [
            ScreenEditorTemplate(key: widget.screenEditorTemplateKey),
            Obx(() => AnimatedOpacity(
                opacity: viewModelMain.appLoaded.value ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: Center(
                    child: SpinKitFadingCube(
                  color: navigationBarBackgroundColor,
                  size: 30.0,
                )))),
            getDataScreen(),
            getResultScreen(),
            Align(
              child: Logo(),
              alignment: Alignment.topLeft,
            ),
            Obx(() => AnimatedOpacity(
                opacity: viewModelMain.appLoaded.value ? 1 : 0,
                duration: Duration(milliseconds: 500),
                child: Align(
                  child: BarSteps(),
                  alignment: Alignment.topCenter,
                ))),
            Obx(() => AnimatedOpacity(
                  opacity: viewModelMain.appLoaded.value ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: Align(
                    child: Container(
                        width: (MediaQuery.of(context).size.height *
                                heightPercentage) /
                            sqrt(2),
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          children: [
                            BarToolsEditor(
                              screenEditorDataKey: widget.screenEditorDataKey,
                              screenEditorResultKey:
                                  widget.screenEditorResultKey,
                              screenEditorTemplateKey:
                                  widget.screenEditorTemplateKey,
                            ),
                            Spacer(),
                            getEditorNavigationButton(),
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

  /*List<Widget> buildNavigationOverlay(BuildContext context) {
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
  }*/

  /*navigatePrevious(ContentTypes header, BuildContext context) {
    _controllersHeader?.animateTo(0,
        curve: Curves.linear, duration: Duration(seconds: 1));
  }*/

  /*navigateNext(ContentTypes header, BuildContext context) {
    _controllersHeader?.animateTo(30,
        curve: Curves.linear, duration: Duration(seconds: 1));
  }*/

  Widget getEditorNavigationButton() {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    String? text;
    switch (viewModelMain.currentEditorStep.value) {
      case EditorSteps.Template:
        text = "Daten eingeben";
        // onClick=openPreview;
        break;
      case EditorSteps.Data:
        text = "Fertigstellen";
        //onClick=()=>openPreview();

        break;
      case EditorSteps.Result:
        text = null;
        break;
    }

    return text != null
        ? ButtonNavigation(
            onClick: () => navigateToNextStep(),
            text: text,
            icon: Icons.done_rounded,
          )
        : Container();
  }

  /// Navigates to the next step in the global navigation
  navigateToNextStep() {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    switch (viewModelMain.currentEditorStep.value) {
      case EditorSteps.Template:
        widget.screenEditorTemplateKey.currentState?.save();
        viewModelMain.currentEditorStep.value = EditorSteps.Data;
        break;
      case EditorSteps.Data:
        viewModelMain.currentEditorStep.value = EditorSteps.Result;
        break;
      case EditorSteps.Result:
        break;
    }
  }

  Widget getResultScreen() {
    return CircularRevealAnimation(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: previewBackgroundColor,
        child: ScreenEditorResult(key: widget.screenEditorResultKey),
        alignment: Alignment.center,
      ),
      animation: resultScreenAnimation,
      centerAlignment: Alignment.topCenter,
    );
  }

  Widget getDataScreen() {
    return CircularRevealAnimation(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: previewBackgroundColor,
        child: ScreenEditorData(
          key: widget.screenEditorDataKey,
        ),
        alignment: Alignment.center,
      ),
      animation: dataScreenAnimation,
      centerAlignment: Alignment.bottomCenter,
    );
  }

  showDataScreen() {
    widget.screenEditorDataKey.currentState!.setState(() {});

    if (dataScreenController.status == AnimationStatus.forward ||
        dataScreenController.status == AnimationStatus.completed) {
      dataScreenController.reverse();
    } else {
      dataScreenController.forward();
    }
  }

  showTemplateScreen() {
    dataScreenController.reverse();
    resultScreenController.reverse();
  }

  void showResultScreen() {
    widget.screenEditorResultKey.currentState!.setState(() {});
    if (resultScreenController.status == AnimationStatus.forward ||
        resultScreenController.status == AnimationStatus.completed) {
      resultScreenController.reverse();
    } else {
      resultScreenController.forward();
    }
  }
}
