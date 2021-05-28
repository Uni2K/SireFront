import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_widgets.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_default_action.dart';
import 'package:sire/widgets/misc/picker_color.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            width: 400,
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
                    height: 60,
                  ),
                  Flexible(
                      child: SizedBox(
                          width: 400,
                          child: AspectRatio(
                              aspectRatio: 2,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: dividerColor,
                                  ),
                                  child: Stack(
                                    children: [
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
                                            margin: EdgeInsets.only(
                                                right: 4, top: 2),
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
                                  ))))),
                  SizedBox(
                    height: 60,
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
                          control
                              .toImage()
                              .then((value) => widget.onFinish(value));
                        },
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
