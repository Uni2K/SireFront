import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_default_action.dart';
import 'package:sire/widgets/misc/picker_color.dart';
import 'dart:ui' as ui;

class DialogLine extends StatefulWidget {
  DialogLine({Key? key, required this.onFinish}) : super(key: key);

  final ValueChanged<ByteData?> onFinish;

  @override
  _DialogLineState createState() => _DialogLineState();
}

class _DialogLineState extends State<DialogLine> {
  List<Color> availableColors = {
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.blueGrey
  }.toList();
  Color chosenColor = Colors.black;

  TextEditingController _textEditingController = TextEditingController();
  GlobalKey _textEditingKey = GlobalKey();
  late FToast fToast;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  final double width = 500;
  bool line = true;
  bool text = true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            width: width,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 13),
            child: Material(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Zeile für Unterschrift erstellen",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      ButtonCircleNeutral(
                        icon: Icon(
                          Icons.close,
                          size: 23,
                          color: Colors.black,
                        ),
                        background: false,
                        onClick: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: dividerColor,
                      ),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: getContent(),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      IntrinsicWidth(
                          child: ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                             minVerticalPadding: 0,
                             horizontalTitleGap: 0,
                             dense: true,
                             child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Line einfügen",style: TextStyle(fontSize: 15),),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: line,
                              onChanged:!text?null: (x) {
                                setState(() {
                                  line = x!;
                                });
                              }))),
                      SizedBox(width: 20),
                      IntrinsicWidth(
                          child:  ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              child:CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Text einfügen",style: TextStyle(fontSize: 15)),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: text,
                              onChanged: !line?null:(x) {
                                setState(() {
                                  text = x!;
                                });
                              })))
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ButtonDefaultAction(
                        text: 'Fertig',
                        icon: Icons.check,
                        onClick: () {
                         if( _textEditingController.text.length>0 || !text){
                          FocusScope.of(context).unfocus();
                          Timer(
                              Duration(
                                milliseconds: 500,
                              ), () {
                            _captureImage()
                                .then((value) => widget.onFinish(value));
                          });
                         }else{
                           fToast.removeQueuedCustomToasts();
                           Widget toast = Container(
                             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(25.0),
                               color: primaryColor,
                             ),
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Icon(Icons.error, color:Colors.white),
                                 SizedBox(
                                   width: 12.0,
                                 ),
                                 Text("Bitte Text eingeben", style: TextStyle(color:Colors.white)),
                               ],
                             ),
                           );


                           fToast.showToast(
                             child: toast,
                             gravity: ToastGravity.BOTTOM,
                             toastDuration: Duration(seconds: 2),
                           );

                         }


                         },
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  Future<ByteData?> _captureImage() async {
    try {
      RenderRepaintBoundary? boundary = _textEditingKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Widget getContent() {
    return  Column(children: [
          Flexible(
            child: SizedBox(),
            flex: 3,
            fit: FlexFit.tight,
          ),
          RepaintBoundary(
          key: _textEditingKey,
          child:   Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          if (line)
            FractionallySizedBox(
                widthFactor: 0.6,
                child: Container(
                  color: Colors.black,
                  height: 2,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                )),
          if (text)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IntrinsicWidth(
                    child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  //   strutStyle: StrutStyle( fontSize: 40,height: 1.1),
                  autofocus: true,
                  controller: _textEditingController,
                ))),
                  ])),
          Flexible(
            child: SizedBox(),
            flex: 3,
            fit: FlexFit.tight,
          ),
        ]);
  }
}
