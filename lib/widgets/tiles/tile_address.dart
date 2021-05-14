import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/input/inputfield_default.dart';

class TileAddress extends StatefulWidget {
  TileAddress({Key? key}) : super(key: key);

  @override
  _TileAddressState createState() => _TileAddressState();
}

class _TileAddressState extends State<TileAddress> {
  TextEditingController textEditingControllerNameAbs =
      new TextEditingController(text: "Max Mustermann");
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
      ViewModelMain viewModelMain=Get.put(ViewModelMain());
      viewModelMain.pagePrototypeKey?.currentState?.changeHeaderContent("name",textEditingControllerNameAbs.text);
    });
    textEditingControllerStreetAbs.addListener(() {
      ViewModelMain viewModelMain=Get.put(ViewModelMain());
      String text=textEditingControllerNameAbs.text+" "+textEditingControllerStreetNrAbs.text;
      viewModelMain.pagePrototypeKey?.currentState?.changeHeaderContent("street",text);
    });
    textEditingControllerCityAbs.addListener(() {
      ViewModelMain viewModelMain=Get.put(ViewModelMain());
      String text=textEditingControllerZipAbs.text+" "+textEditingControllerCityAbs.text;
      viewModelMain.pagePrototypeKey?.currentState?.changeHeaderContent("city",text);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
                      textEditingController: textEditingControllerNameAbs)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: InputfieldDefault(
                      hint: "Firma",
                      textEditingController: textEditingControllerCompanyAbs)),
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
                      textEditingController: textEditingControllerStreetAbs)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 1,
                  child: InputfieldDefault(
                      hint: "Nummer",
                      textEditingController: textEditingControllerStreetNrAbs)),
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
                      textEditingController: textEditingControllerZipAbs)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 3,
                  child: InputfieldDefault(
                      hint: "Ort",
                      textEditingController: textEditingControllerCityAbs)),
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
                      textEditingController: textEditingControllerNameEmp)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: InputfieldDefault(
                      hint: "Firma",
                      textEditingController: textEditingControllerCompanyEmp)),
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
                      textEditingController: textEditingControllerStreetEmp)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 1,
                  child: InputfieldDefault(
                      hint: "Nummer",
                      textEditingController: textEditingControllerStreetNrEmp)),
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
                      textEditingController: textEditingControllerZipEmp)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 3,
                  child: InputfieldDefault(
                      hint: "Ort",
                      textEditingController: textEditingControllerCityEmp)),
            ],
          ),
        ],
      ),
    );
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
