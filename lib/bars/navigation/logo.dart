import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sire/constants/constant_color.dart';

class Logo extends StatefulWidget {
  Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      color: navigationBarBackgroundColor,
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
    );
  }
}
