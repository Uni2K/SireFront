import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/widgets/page/page_prototype.dart';
import 'package:vector_math/vector_math_64.dart';
import '../misc/interactive_viewer_adjusted.dart';
import 'package:sire/widgets/misc/interactive_viewer_adjusted.dart'
    as TrafoController;

class InteractivePage extends StatefulWidget {
  final GlobalKey<InteractiveViewerAdjustedState> viewerKey = GlobalKey();
  final GlobalKey<PagePrototypeState> pageKey;
  final GlobalKey repaintKey;

  InteractivePage({GlobalKey? key, required this.pageKey, required this.repaintKey}) : super(key: key);

  @override
  InteractivePageState createState() => InteractivePageState();
}

class InteractivePageState extends State<InteractivePage>
    with TickerProviderStateMixin {
  late TrafoController.TransformationController controller;
  late double widthViewer;
  late double heightViewer;
  late double topOffsetStart;
  late Offset fixedFocalPoint;
  late double diffHalf;

  late AnimationController pageAnimator;

  @override
  void initState() {
    super.initState();
    pageAnimator =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    pageAnimator.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Matrix4 matrix4 = Matrix4.identity();
    controller = TrafoController.TransformationController(matrix4);

    ///dimensions of viewer and child
    widthViewer =UtilSize.getViewerWidth(context);
    heightViewer = UtilSize.getViewerHeight(context);
    double widthPage =UtilSize.getPageWidth(context);
    double heightPage = UtilSize.getPageHeight(context);

    ///needed to constrain the focal points to the vertical axis, the second value is not used
    fixedFocalPoint = Offset(UtilSize.dp(widthViewer / 2, 2), UtilSize.dp(heightViewer / 2, 2));

    ///start position
    topOffsetStart = UtilSize.getPageOffsetTop(context);
    double diff = widthViewer - widthPage;
    diffHalf = UtilSize.dp(diff / 2, 2);
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
            minScale: minScale,
            key: widget.viewerKey,
            maxScale: maxScale,
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
                  height: heightPage,
                  width: widthPage,
                  child: RepaintBoundary(
                      key: widget.repaintKey, child: PagePrototype( key: widget.pageKey))),
            ),
          )),
    );
  }

  TickerFuture resetPage() {
    Vector3 endTranslation = Vector3(diffHalf, topOffsetStart, 0);
    return translateScaleAnimation(1, endTranslation);
  }

  TickerFuture translateScaleAnimation(double? scale, Vector3? endTranslation) {
    PointerSignalEvent event = PointerScrollEvent(position: fixedFocalPoint);

    pageAnimator.dispose();
    pageAnimator =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    if (scale != null) {
      double currentScale = controller.value.getMaxScaleOnAxis();
      Animation<double> scaleAnimation =
          Tween<double>(begin: currentScale, end: scale).animate(
        CurvedAnimation(
          parent: pageAnimator,
          curve: Interval(
            0.0,
            endTranslation == null ? 1 : 0.6,
            curve: Curves.ease,
          ),
        ),
      );
      scaleAnimation.addListener(() {
        double value = scaleAnimation.value;
        if (value != scale)
          widget.viewerKey.currentState
              ?.receivedPointerSignal(event, false, scaleChangeFix: value);
      });
    }
    if (endTranslation != null) {
      Vector3 currentTranslation = controller.value.getTranslation();

      Animation<Vector3> translateAnimation =
          Tween<Vector3>(begin: currentTranslation, end: endTranslation)
              .animate(CurvedAnimation(
        parent: pageAnimator,
        curve: Interval(
          scale == null ? 0 : 0.61,
          1,
          curve: Curves.ease,
        ),
      ));
      translateAnimation.addListener(() {
        translateBy(Offset(endTranslation.x, endTranslation.y));
      });
    }

    pageAnimator.reset();
    return pageAnimator.forward();
  }

  void animateScaleTo(double target) {
    translateScaleAnimation(target, null);
  }

  void translateBy(Offset d) {
    Vector3 translation = controller.value.getTranslation();
    d = Offset(translation.x - d.dx, translation.y - d.dy);
    if ((d.dx == 0 || d.dx == -0) && (d.dy == 0 || d.dy == -0)) return;
    PointerSignalEvent event =
        PointerScrollEvent(position: fixedFocalPoint, scrollDelta: d);
    widget.viewerKey.currentState?.receivedPointerSignal(event, true); //
    // translateScaleAnimation(null, translation);
  }
}
