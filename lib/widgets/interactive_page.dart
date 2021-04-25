import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:vector_math/vector_math_64.dart';
import 'editor/page_editing.dart';
import 'misc/interactive_viewer_adjusted.dart';
import 'package:sire/widgets/misc/interactive_viewer_adjusted.dart'
as TrafoController;

class InteractivePage extends StatefulWidget {
  GlobalKey<InteractiveViewerAdjustedState> viewerKey = GlobalKey();

  InteractivePage({GlobalKey? key}) : super(key: key);

  @override
  InteractivePageState createState() => InteractivePageState();
}

class InteractivePageState extends State<InteractivePage> with SingleTickerProviderStateMixin {
  late TrafoController.TransformationController controller;
  late double widthViewer;
  late double heightViewer;
  late double topOffsetStart;
  late Offset fixedFocalPoint;
  late double  diffHalf;

  late AnimationController pageAnimator;


  @override
  void initState() {
    super.initState();
    pageAnimator =  AnimationController(vsync: this, duration: Duration(milliseconds:  500));

  }

  @override
  Widget build(BuildContext context) {

    Matrix4 matrix4 = Matrix4.identity();
    controller = TrafoController.TransformationController(matrix4);

    ///dimensions of viewer and child
    widthViewer = MediaQuery
        .of(context)
        .size
        .width * 0.6;
    heightViewer = MediaQuery
        .of(context)
        .size
        .height;
    double widthPage = min(
        MediaQuery
            .of(context)
            .size
            .height * heightPercentage,
        widthViewer * 0.9);
    double heightPage = widthPage * sqrt(2);

    ///needed to constrain the focal points to the vertical axis, the second value is not used
    fixedFocalPoint = Offset(widthViewer / 2, heightViewer / 2);

    ///start position
    topOffsetStart = MediaQuery
        .of(context)
        .size
        .height / 5;
    double diff = widthViewer - widthPage;
    diffHalf = diff / 2;
    controller.value.translate(diffHalf, topOffsetStart);

    controller.addListener(() {
      ///limits the page at top and bottom
      Vector3 tr = controller.value.getTranslation();
      bool set = false;
      double limit =
          topOffsetStart * (pow(controller.value.getMaxScaleOnAxis(), 3));
      if (tr.y < -limit) {
        tr.y = -limit;
        set = true;
      } else if (tr.y > limit) {
        tr.y = limit;
        set = true;
      }
      if (set) {
        controller.value.setTranslation(tr);
      }
    });
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: EdgeInsets.only(left: 0, top: 0),
          width: widthViewer,
          height: heightViewer,
          child: InteractiveViewerAdjusted(
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.7,
            key: widget.viewerKey,
            maxScale: 1.0,
            heightParent: heightViewer,
            heightChild: heightPage,
            fixedFocalPoint: fixedFocalPoint,
            alignPanAxis: true,
            constrained: false,
            panEnabled: true,
            clipBehavior: Clip.none,
            scaleEnabled: true,
            transformationController: controller,
            child: Center(
              child: Container(
                  height: heightPage, width: widthPage, child: PageEditing()),
            ),
          )),
    );
  }

  void animateScaleTo(double i) {
    double? scale = controller.value.getMaxScaleOnAxis();
    double targetScale = 1;
    double scaleTrafo = 1 / (scale / targetScale);
    PointerSignalEvent event = PointerScrollEvent(position:fixedFocalPoint );


    Animation<double> scaleAnimation=Tween<double>(begin: 1, end: 1.01).animate( CurvedAnimation(
      parent: pageAnimator,
      curve: Interval(
        0.0, 0.6,
        curve: Curves.ease,
      ),
    ),);
    scaleAnimation.addListener(() {
      widget.viewerKey.currentState?.receivedPointerSignal(event,scaleChangeFix: scaleAnimation.value); //cant extend the maxscale -> its arbitrary what the end tween is
    });
    //SCROLLWHEEL -> TRANSLATE NOT ZOOM depending on the mode
    Vector3 currentTranslation=controller.value.getTranslation();
    Vector3 endTranslation=Vector3(diffHalf, topOffsetStart,0);

    Animation<Vector3> translateAnimation=Tween<Vector3>(begin: currentTranslation, end:  endTranslation).animate(CurvedAnimation(
      parent: pageAnimator,
      curve: Interval(
        0.61, 1,
        curve: Curves.ease,
      ),
    ));
    translateAnimation.addListener(() {
      controller.value.setTranslation(translateAnimation.value);
    });




    pageAnimator.reset();
    pageAnimator.forward();









   // controller.value.setTranslation(Vector3(diffHalf, topOffsetStart,0));


    //  controller.value.scale(scaleTrafo, scaleTrafo, 1);
   // controller.notifyListeners();
  }
}
