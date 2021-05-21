import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/screens/screen_main.dart';

class UtilSize {
  static double getViewerWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * viewerWidth;
  }
  static double getViewerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getPageWidth(BuildContext context) {
    return min((MediaQuery.of(context).size.height * heightPercentage),
        getViewerWidth(context) * 0.9);

  }
  static double getPageHeight(BuildContext context) {
    return getPageWidth(context)*sqrt(2);
  }

  static double getPageOffsetTop(BuildContext context) {
    return MediaQuery.of(context).size.height / 5.0;
  }

  static double getPageViewerWidthDifference(BuildContext context) {
    return getViewerWidth(context) - getPageWidth(context);
  }

  ///((getViewerWidth(context) - (getViewerWidth(context) - getPageWidth(context)) / 2) - getPageWidth(context)) / 2;
  static double getContainerDistanceViewer(BuildContext context) {
    return (getViewerWidth(context) - getPageWidth(context)) / 4;
  }
///(getViewerWidth(context) -   getPageViewerWidthDifference(context) / 2) +   getContainerDistanceViewer(context);
  static double getContainerLeft(BuildContext context) {
    return (3*getViewerWidth(context) + getPageWidth(context)) / 4;
  }

  static double getToolbarTop(BuildContext context) {
    return getContainerDistanceViewer(context);
  }


  static double getTopOffsetForShowingContainer(BuildContext context,ShowingContainer showingContainer) {
    double topOffsetPage=getPageOffsetTop(context);
    switch (showingContainer) {
      case ShowingContainer.HeaderSelection:
        return topOffsetPage - 50;
      case ShowingContainer.EditingTool:
        return topOffsetPage - 60;
      case ShowingContainer.Welcome:
        return topOffsetPage;
      case ShowingContainer.Final:
        return topOffsetPage;
    }
  }

  static double getHeaderMinHeigth(BuildContext context) {
   return  getPageWidth(context) * sqrt(2) * headerMinPercentage ;
  }

  static double getHeaderMaxHeigth(BuildContext context) {
    return  getPageWidth(context) * sqrt(2) * headerMaxPercentage ;
  }

  static double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }



}
