import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/widgets/page/headers/header_prototype.dart';

class Header2 extends HeaderPrototype {
  Header2({bool readOnly = false}) : super(readOnly: readOnly);

  @override
  Widget build(BuildContext context) {
    inputFields.clear();

    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: UtilSize.getHeaderMinHeigth(context),
          maxHeight: UtilSize.getHeaderMaxHeigth(context)),
      child: Container(
          margin: getMargin(context),

          padding: getPadding(context).copyWith(left: 0),
          //    width:   ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2)) - spacePages * 2,,
          child: IntrinsicHeight(
              child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.only(
                              left: 35, right: 10, bottom: 10, top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              createInputField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25),
                                  initialContent: "Absender Name",
                                  contentDescription: "abs;name"),
                              createInputField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  initialContent: "Absender Firma",
                                  contentDescription: "abs;company")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        IntrinsicWidth(
                            child: createInputField(
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17),
                                initialContent: "Ort, Datum",
                                contentDescription: "city;date"))
                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                                child: createInputField(
                                    style: TextStyle(fontSize: 14),
                                    initialContent: "Absender Email",
                                    contentDescription: "abs;email")),
                            SizedBox(
                              width: 7,
                            ),
                            FaIcon(
                              FontAwesomeIcons.solidEnvelope,
                              size: getMiniIconSize(),
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                                child: createInputField(
                                    style: TextStyle(fontSize: 14),
                                    initialContent: "Absender Telefon",
                                    contentDescription: "abs;fon")),
                            SizedBox(
                              width: 7,
                            ),
                            FaIcon(
                              FontAwesomeIcons.phone,
                              size: getMiniIconSize(),
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                                child: createInputField(
                                    style: TextStyle(fontSize: 14),
                                    initialContent: "Absender Ort",
                                    contentDescription: "abs;city")),
                            SizedBox(
                              width: 7,
                            ),
                            FaIcon(
                              FontAwesomeIcons.locationArrow,
                              size: getMiniIconSize(),
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                                child: createInputField(
                                    style: TextStyle(fontSize: 14),
                                    initialContent: "Absender Website",
                                    contentDescription: "abs;website")),
                            SizedBox(
                              width: 7,
                            ),
                            FaIcon(
                              FontAwesomeIcons.blog,
                              size: getMiniIconSize(),
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicWidth(
                                child: createInputField(
                                    style: TextStyle(fontSize: 14),
                                    initialContent: "Absender LinkedIn",
                                    contentDescription: "abs;linkedin")),
                            SizedBox(
                              width: 7,
                            ),
                            FaIcon(
                              FontAwesomeIcons.linkedin,
                              size: getMiniIconSize(),
                              color: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ))),
    );
  }
}
