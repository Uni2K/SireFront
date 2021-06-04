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

  Map<String,TextEditingController> registeredControllers=Map();




  @override
  void initState() {
    super.initState();
  }

  void updateTextMap(String type) {
    Map<String, String> map = Map();

    for(String ident in registeredControllers.keys){
      if(ident.contains(type+";")){
        map[ident.replaceAll(type+";", "")]=registeredControllers[ident]!.text;


      }

    }
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    viewModelMain.pagePrototypeKey?.currentState
        ?.changeHeaderContent(type, map);
  }

  final _formKey = GlobalKey<FormState>();
  ViewModelMain viewModelMain = Get.put(ViewModelMain());

  @override
  Widget build(BuildContext context) {
 //   registeredControllers.values.forEach((element) {element.dispose();});

    return Container(
        //height: isMinimized ? 100 : null,
        padding: EdgeInsets.all(10),
        child: FocusTraversalGroup(
            policy: ReadingOrderTraversalPolicy(),
            child: Obx(() {
              registeredControllers.clear();

              viewModelMain.currentHeader.value.round(); //dummy
              return Form(
                key: _formKey,
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
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: getChilds("abs"),
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
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: getChilds("emp"),
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  widget.onFinish.call();
                                });
                              }
                            },
                          )),
                    )
                  ],
                ),
              );
            })));
  }

  @override
  void dispose() {
    registeredControllers.values.forEach((element) {element.dispose();});
    super.dispose();
  }

  List<Widget> getChilds(String identifier) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());
    List<String?> emp = (viewModelMain.pagePrototypeKey!.currentState!
        .pageHeaderKey.currentState!.widget.content
        .getContentChilds(identifier));

    List<Widget> childs = List.empty(growable: true);

    for (String? emps in emp) {
      if (emps == null) continue;

      TextEditingController textEditingController=TextEditingController();
      textEditingController.addListener(() {
        updateTextMap(identifier);
      });
      String s=identifier+";"+emps;
      registeredControllers[s]=textEditingController;

      childs.add(FractionallySizedBox(
          widthFactor: getWeights(emps),
          child:InputfieldDefault(
          hint: getName(emps), textEditingController: textEditingController)));
    }

    return childs;
  }
  double getWeights(String identifier) {
    switch(identifier){
      case "city": return 0.3;
      case "street": return 0.6;
      case "name": return 0.5;
      case "company": return 0.4;
      case "date": return 0.3;
      case "email": return 0.4;
      case "fon": return 0.4;
      case "website": return 0.4;
      case "linkedin": return 0.4;
      case "twitter": return 0.3;
      case "facebook": return 0.4;
    }
    return 0.4;
  }

  String getName(String identifier) {
  switch(identifier){
    case "city": return "Postleitzahl & Stadt";
    case "street": return "Straße & Hausnummer";
    case "name": return "Name";
    case "company": return "Firma";
    case "date": return "Datum";
    case "email": return "E-Mail";
    case "fon": return "Telefon";
    case "website": return "Webseite";
    case "linkedin": return "LinkedIn";
    case "twitter": return "Twitter";
    case "facebook": return "Facebook";
  }
    return "Weiteres";
  }
}

/*
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
 */

/*
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
 */
