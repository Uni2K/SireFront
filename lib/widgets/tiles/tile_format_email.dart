import 'package:flutter/material.dart';
import 'package:sire/constants/constant_color.dart';

class TileFormatEmail extends StatelessWidget {
  final VoidCallback onFinish;

  const TileFormatEmail({Key? key, required this.onFinish}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "testgmail.com",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          SizedBox(
            width: 15,
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: 15,
            color: buttonTextColor,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            " test@gmail.com ",
            style: TextStyle(color: Colors.white, backgroundColor: primaryColor),
          ),
        ],
      )
    );
  }
}
