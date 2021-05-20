import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_default_light.dart';
import 'package:sire/widgets/input/inputfield_default.dart';

class TileAddress extends StatefulWidget {
  TileAddress({Key? key, required this.onFinish}) : super(key: key);

  final VoidCallback onFinish;

  @override
  _TileAddressState createState() => _TileAddressState();
}

class _TileAddressState extends State<TileAddress> {

  TextEditingController textEditingControllerNameAbs =
      new TextEditingController();
  TextEditingController textEditingControllerCompanyAbs =
      new TextEditingController();
  TextEditingController textEditingControllerStreetAbs =
      new TextEditingController();
  TextEditingController textEditingControllerStreetNrAbs =
      new TextEditingController();
  TextEditingController textEditingControllerZipAbs =
      new TextEditingController();
  TextEditingController textEditingControllerCityAbs =
      new TextEditingController();

  TextEditingController textEditingControllerNameEmp =
      new TextEditingController();
  TextEditingController textEditingControllerCompanyEmp =
      new TextEditingController();
  TextEditingController textEditingControllerStreetEmp =
      new TextEditingController();
  TextEditingController textEditingControllerStreetNrEmp =
      new TextEditingController();
  TextEditingController textEditingControllerZipEmp =
      new TextEditingController();
  TextEditingController textEditingControllerCityEmp =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingControllerNameAbs.addListener(() {
      updateTextMap("abs");
    });
    textEditingControllerStreetAbs.addListener(() {
      updateTextMap("abs");
    });
    textEditingControllerStreetNrAbs.addListener(() {
      updateTextMap("abs");
    });
    textEditingControllerCityAbs.addListener(() {
      updateTextMap("abs");
    });
    textEditingControllerZipAbs.addListener(() {
      updateTextMap("abs");
    });
    textEditingControllerCompanyAbs.addListener(() {
      updateTextMap("abs");
    });

    textEditingControllerNameEmp.addListener(() {
      updateTextMap("emp");
    });
    textEditingControllerStreetEmp.addListener(() {
      updateTextMap("emp");
    });
    textEditingControllerStreetNrEmp.addListener(() {
      updateTextMap("emp");
    });
    textEditingControllerCityEmp.addListener(() {
      updateTextMap("emp");
    });
    textEditingControllerZipEmp.addListener(() {
      updateTextMap("emp");
    });
    textEditingControllerCompanyEmp.addListener(() {
      updateTextMap("emp");
    });
  }

  void updateTextMap(String type) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    Map<String, String> map = Map();
    map["name"] = textEditingControllerNameAbs.text;
    map["street"] = textEditingControllerStreetAbs.text +
        " " +
        textEditingControllerStreetNrAbs.text;
    map["city"] = textEditingControllerZipAbs.text +
        " " +
        textEditingControllerCityAbs.text;

    viewModelMain.pagePrototypeKey?.currentState
        ?.changeHeaderContent(type, map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: isMinimized ? 100 : null,
        padding: EdgeInsets.all(10),
        child:  FocusTraversalGroup(
              policy: ReadingOrderTraversalPolicy(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Absender",
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: InputfieldDefault(
                              hint: "Name",
                              textEditingController:
                                  textEditingControllerNameAbs)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: InputfieldDefault(
                              hint: "Firma",
                              textEditingController:
                                  textEditingControllerCompanyAbs)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          flex: 3,
                          child: InputfieldDefault(
                              hint: "Straße",
                              textEditingController:
                                  textEditingControllerStreetAbs)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 1,
                          child: InputfieldDefault(
                              hint: "Nummer",
                              textEditingController:
                                  textEditingControllerStreetNrAbs)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          flex: 1,
                          child: InputfieldDefault(
                              hint: "Postleitzahl",
                              textEditingController:
                                  textEditingControllerZipAbs)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 3,
                          child: InputfieldDefault(
                              hint: "Ort",
                              textEditingController:
                                  textEditingControllerCityAbs)),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Empfänger",
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: InputfieldDefault(
                              hint: "Name",
                              textEditingController:
                                  textEditingControllerNameEmp)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: InputfieldDefault(
                              hint: "Firma",
                              textEditingController:
                                  textEditingControllerCompanyEmp)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          flex: 3,
                          child: InputfieldDefault(
                              hint: "Straße",
                              textEditingController:
                                  textEditingControllerStreetEmp)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 1,
                          child: InputfieldDefault(
                              hint: "Nummer",
                              textEditingController:
                                  textEditingControllerStreetNrEmp)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          flex: 1,
                          child: InputfieldDefault(
                              hint: "Postleitzahl",
                              textEditingController:
                                  textEditingControllerZipEmp)),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 3,
                          child: InputfieldDefault(
                              hint: "Ort",
                              textEditingController:
                                  textEditingControllerCityEmp)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: ButtonDefaultLight(
                          text: "Fertig",
                          icon: FontAwesomeIcons.check,
                          onClick: () {
                            setState(() {
                             widget.onFinish.call();
                            });
                          },
                        )),
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    textEditingControllerNameAbs.dispose();
    textEditingControllerCompanyAbs.dispose();
    textEditingControllerStreetAbs.dispose();
    textEditingControllerStreetNrAbs.dispose();
    textEditingControllerZipAbs.dispose();
    textEditingControllerCityAbs.dispose();

    textEditingControllerNameEmp.dispose();
    textEditingControllerCompanyEmp.dispose();
    textEditingControllerStreetEmp.dispose();
    textEditingControllerStreetNrEmp.dispose();
    textEditingControllerZipEmp.dispose();
    textEditingControllerCityEmp.dispose();

    super.dispose();
  }
}
