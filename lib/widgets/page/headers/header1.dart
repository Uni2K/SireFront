import 'package:flutter/material.dart';
import 'package:sire/widgets/page/headers/header_prototype.dart';

class Header1 extends HeaderPrototype {
  Header1({bool readOnly = false}) : super(readOnly: readOnly);

  @override
  Widget build(BuildContext context) {


    inputFields.clear();

    return Container(
      padding: getPadding(context),
    //  margin: getMargin(context),
      child: IntrinsicHeight(
          child: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    createInputField(
                      contentDescription: "abs;name;street;city",
                      initialContent: '''Absender Name
Absender Straße
Absender Stadt
''',
                    ),
                  ],
                ),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    createInputField(
                      style: getBoldTextStyle(),
                      initialContent: 'Bemerkung',
                    ),
                    SizedBox(
                      height: getDefaultSpace(),
                    ),
                    createInputField(
                      contentDescription: "emp;name;street;city",
                      initialContent: '''Empfänger Name
Empfänger Straße
Empfänger Stadt
''',
                    ),
                    SizedBox(
                      height: getDefaultSpace(),
                    ),
                    createInputField(
                      initialContent: 'Stadt, Datum',
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
