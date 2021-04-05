import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class Logo extends StatefulWidget {
  Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
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
                    ))),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 15, right: 20, top: 4, bottom: 4)),
          ),
          onPressed: () {

          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "pentagon-up.png",
                color: Colors.white,
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Sire",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: "Berkshire"),
              )
            ],
          ),
        )));
  }
}


