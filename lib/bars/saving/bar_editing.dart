import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_color.dart';

class BarEditing extends StatefulWidget {
  BarEditing({Key? key}) : super(key: key);

  @override
  _BarEditingState createState() => _BarEditingState();
}

class _BarEditingState extends State<BarEditing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,

      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: navigationBarBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Icon(Icons.delete_forever, color: Colors.white,size: 18,),
          SizedBox(width: 15,),
          Icon(Icons.help, color: Colors.white,size: 18,),
          SizedBox(width: 15,),
          Icon(Icons.visibility, color: Colors.white,size: 18,),
          SizedBox(width: 40,),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: ColorUtil.getColorFromHex("#035F86"),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: double.infinity),
              child:Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.undo, color: Colors.white,size: 18,),
              SizedBox(width: 5,),
             VerticalDivider(color: Colors.white, thickness: 0.5,),
                SizedBox(width: 5,),
              Icon(Icons.redo, color: Colors.white,size: 18,),
            ],),
            )),
          SizedBox(width: 0,),


        ],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
