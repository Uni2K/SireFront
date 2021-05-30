import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_widgets.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_default_action.dart';
import 'package:sire/widgets/misc/picker_color.dart';
import 'dart:ui' as ui;

class DialogSignature extends StatefulWidget {
  DialogSignature({Key? key, required this.onFinish}) : super(key: key);

  final ValueChanged<ByteData?> onFinish;

  @override
  _DialogSignatureState createState() => _DialogSignatureState();
}

class _DialogSignatureState extends State<DialogSignature> {
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.01,
    velocityRange: 5.2,
  );
  double strokeWidth = 3;
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

  @override
  void dispose() {
    _textEditingController.dispose();
    control.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final double width = 500;
  int index = 0;

  ByteData? _pickedImage;
  final picker = ImagePicker();

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
                        "Signatur zeichnen",
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
                        onClick: () => null,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: width,
                      child: AspectRatio(
                          aspectRatio: 2,
                          child: DefaultTabController(
                              initialIndex: index,
                              length: 3,
                              child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  appBar: PreferredSize(
                                      preferredSize: Size.fromHeight(34.0),
                                      child: TabBar(
                                        onTap: (x) {
                                          index = x;
                                        },
                                        isScrollable: true,
                                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                                        labelPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        // indicatorPadding:  EdgeInsets.symmetric(horizontal: 20),
                                        indicatorColor: primaryColor,
                                        tabs: [
                                          Tab(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.signature,
                                                color: buttonTextColor,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Zeichnen",
                                                style: TextStyle(
                                                  color: buttonTextColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                          Tab(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.font,
                                                color: buttonTextColor,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Schreiben",
                                                style: TextStyle(
                                                  color: buttonTextColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                          Tab(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.fileUpload,
                                                color: buttonTextColor,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Bild einfügen",
                                                style: TextStyle(
                                                  color: buttonTextColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ],
                                      )),
                                  body: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: dividerColor,
                                        ),
                                      ),
                                      TabBarView(
                                        children: getTabChildren(),
                                      ),
                                    ],
                                  ))))),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.format_color_text_rounded,
                        color: buttonTextColor,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: PickerColor(
                              onSelectColor: (x) => setState(() {
                                    chosenColor = x;
                                  }),
                              availableColors: availableColors,
                              initialColor: chosenColor))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.line_weight_rounded,
                        color: buttonTextColor,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: SliderTheme(
                            data: UtilWidgets.getDefaultSliderTheme(context)
                                .copyWith(
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 6)),
                            child: Slider(
                              value: strokeWidth,
                              min: 1,
                              focusNode: FocusNode(
                                  skipTraversal: true,
                                  descendantsAreFocusable: false),
                              max: 10,
                              divisions: 10,
                              onChanged: (value) {
                                setState(() {
                                  strokeWidth = value;
                                });
                              },
                            )),
                      ),
                      Spacer(),
                      ButtonDefaultAction(
                        text: 'Fertig',
                        icon: Icons.check,
                        onClick: () {
                          if (index == 0) {
                            control
                                .toImage()
                                .then((value) => widget.onFinish(value));
                          } else if (index == 1) {
                            _captureImage()
                                .then((value) => widget.onFinish(value));
                          } else if (index == 2) {
                            widget.onFinish(_pickedImage);
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

  getTabChildren() {
    List<Widget> children = List.empty(growable: true);

    children.add(Stack(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              Flexible(
                child: SizedBox(),
                flex: 3,
                fit: FlexFit.tight,
              ),
              Container(
                color: buttonTextColor.withAlpha(60),
                height: 1,
                width: double.infinity,
              ),
              Flexible(
                child: SizedBox(),
                flex: 6,
                fit: FlexFit.tight,
              ),
              Container(
                color: buttonTextColor.withAlpha(100),
                height: 1,
                width: double.infinity,
              ),
              Flexible(
                child: SizedBox(),
                flex: 3,
                fit: FlexFit.tight,
              ),
            ])),
        Positioned.fill(
            child: HandSignaturePainterView(
          control: control,
          color: chosenColor,
          width: 1.0,
          maxWidth: strokeWidth,
          type: SignatureDrawType.shape,
        )),
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: EdgeInsets.only(right: 4, top: 2),
              child: ButtonCircleNeutral(
                onClick: () {
                  control.clear();
                },
                icon: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                  size: 18,
                ),
                background: true,
              )),
        ),
      ],
    ));
    children.add(Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RepaintBoundary(
                    key: _textEditingKey,
                    child: IntrinsicWidth(
                        child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: buttonTextColor.withAlpha(100)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: buttonTextColor.withAlpha(100)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: buttonTextColor.withAlpha(100)),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      autofocus: true,
                      controller: _textEditingController,
                    ))))),
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: EdgeInsets.only(right: 4, top: 2),
              child: ButtonCircleNeutral(
                onClick: () {
                  control.clear();
                },
                icon: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                  size: 18,
                ),
                background: true,
              )),
        ),
      ],
    ));
    children.add(Stack(
      children: [
        if (_pickedImage != null)
        Positioned.fill(child:Image.memory(_pickedImage!.buffer.asUint8List(), fit: BoxFit.cover,)),
        Align(
            alignment: _pickedImage!=null?Alignment.bottomLeft:Alignment.center,
            child: ButtonDefaultAction(
              text: "Bild auswählen",
              icon: Icons.image_search_rounded,
              onClick: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                Uint8List bytes = await pickedFile!.readAsBytes();
                setState(() {
                  _pickedImage = ByteData.view(bytes.buffer);
                });
              },
            )),
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: EdgeInsets.only(right: 4, top: 2),
              child: ButtonCircleNeutral(
                onClick: () {
                  control.clear();
                },
                icon: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                  size: 18,
                ),
                background: true,
              )),
        ),
      ],
    ));
    return children;
  }
}
