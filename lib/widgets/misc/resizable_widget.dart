import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sire/widgets/menus/menu_signature.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget({required this.child, required this.data});

  final Widget child;
  final ByteData data;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 20.0;
final double INITIAL_HEIGHT=100;
final double INITIAL_WIDTH=200;

class _ResizebleWidgetState extends State<ResizebleWidget> {


  double height = INITIAL_HEIGHT;
  double width = INITIAL_WIDTH;

  double top = 0;
  double left = 0;
  bool selected = false;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  double xPosition = 0;
  double yPosition = 0;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        selected = focusNode.hasFocus;
      });
    });
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((Duration _) {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
            onTap: () {
              focusNode.requestFocus();
            },
            onPanUpdate: (tapInfo) {
              setState(() {
                if (xPosition + tapInfo.delta.dx >= 0)
                  xPosition += tapInfo.delta.dx;
                if (yPosition + tapInfo.delta.dy >= 0)
                  yPosition += tapInfo.delta.dy;
              });
            },
            child: Focus(
                focusNode: focusNode,
                child: SizedBox(
                  height: height + ballDiameter,
                  width: width + ballDiameter,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.all(ballDiameter / 2),
                            child: DottedBorder(
                                dashPattern: [6, 10],
                                strokeWidth: 2,
                                color:
                                    selected ? buttonTextColor : Colors.white,
                                strokeCap: StrokeCap.round,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                child: Container(
                                  height: height,
                                  width: width,
                                  child: widget.child,
                                ))),
                      ),
                      // top left
                      if (selected)
                        Align(
                          alignment: Alignment.topLeft,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var mid = (dx + dy) / 2;
                              var newHeight = height - 2 * mid;
                              var newWidth = width - 2 * mid;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                                width = newWidth > 0 ? newWidth : 0;
                                top = top + mid;
                                left = left + mid;
                              });
                            },
                          ),
                        ),
                      // top middle
                      if (selected)
                        Align(
                          alignment: Alignment.topCenter,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var newHeight = height - dy;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                                top = top + dy;
                              });
                            },
                          ),
                        ),
                      // top right
                      if (selected)
                        Align(
                          alignment: Alignment.topRight,
                          child: MenuButton(
                            onReset: (){
                              setState(() {
                                xPosition=0;
                                yPosition=0;
                                left=0;
                                top=0;
                                width=INITIAL_WIDTH;
                                height=INITIAL_HEIGHT;
                              });

                            },
                            data: widget.data,
                            onDrag: (dx, dy) {
                              var mid = (dx + (dy * -1)) / 2;

                              var newHeight = height + 2 * mid;
                              var newWidth = width + 2 * mid;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                                width = newWidth > 0 ? newWidth : 0;
                                top = top - mid;
                                left = left - mid;
                              });
                            },
                          ),
                        ),
                      // center right
                      if (selected)
                        Align(
                          alignment: Alignment.centerRight,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var newWidth = width + dx;

                              setState(() {
                                width = newWidth > 0 ? newWidth : 0;
                              });
                            },
                          ),
                        ),
                      // bottom right
                      if (selected)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var mid = (dx + dy) / 2;

                              var newHeight = height + 2 * mid;
                              var newWidth = width + 2 * mid;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                                width = newWidth > 0 ? newWidth : 0;
                                top = top - mid;
                                left = left - mid;
                              });
                            },
                          ),
                        ),
                      // bottom center
                      if (selected)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var newHeight = height + dy;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                              });
                            },
                          ),
                        ),
                      // bottom left
                      if (selected)
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var mid = ((dx * -1) + dy) / 2;

                              var newHeight = height + 2 * mid;
                              var newWidth = width + 2 * mid;

                              setState(() {
                                height = newHeight > 0 ? newHeight : 0;
                                width = newWidth > 0 ? newWidth : 0;
                                top = top - mid;
                                left = left - mid;
                              });
                            },
                          ),
                        ),
                      //left center
                      if (selected)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ManipulatingBall(
                            onDrag: (dx, dy) {
                              var newWidth = width - dx;

                              setState(() {
                                width = newWidth > 0 ? newWidth : 0;
                                left = left + dx;
                              });
                            },
                          ),
                        ),
                      // center center
                    ],
                  ),
                ))));
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key? key, required this.onDrag});

  final Function onDrag;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
          color: Colors.white,
          width: ballDiameter,
          height: ballDiameter,
          child: Center(
              child: Container(
            width: ballDiameter / 2,
            height: ballDiameter / 2,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.12),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
          ))),
    );
  }
}

class MenuButton extends StatefulWidget {
  MenuButton({Key? key, required this.onDrag, required this.data, this.onReset});

  final Function onDrag;
  final ByteData data;
  final VoidCallback? onReset;
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        child: MenuSignature(
          onReset: widget.onReset,
          signature: widget.data,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.12),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
