import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class TypeSelector extends StatefulWidget {
  TypeSelector({Key? key}) : super(key: key);

  @override
  _TypeSelectorState createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(child: SizedBox(
        height: 35,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(10),
            backgroundColor:
            MaterialStateProperty.all<Color>(navigationBarBackgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(4),
                        bottomLeft: Radius.circular(4)))),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 15, right: 20, top: 4, bottom: 4)),
          ),
          onPressed: () {

          },
          child: Row(
            children: [
              Icon(Icons.description, color: Colors.white,size: 18,),
              SizedBox(
                width: 10,
              ),
              Text(
                "Einfaches Anschreiben",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        )));
  }
}
