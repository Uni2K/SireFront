import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_color.dart';

class ButtonNavigation extends StatefulWidget {
  ButtonNavigation({Key? key, required this.onClick, required this.icon, required this.text}) : super(key: key);
  final VoidCallback onClick;
  final IconData icon;
  final String text;
  @override
  _ButtonNavigationState createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(10),
            backgroundColor:
                MaterialStateProperty.all<Color>(navigationBarBackgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0))),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 4, right: 20, top: 4, bottom: 4)),
          ),
          onPressed: () {
            widget.onClick();
          },
          child: Row(
            children: [
              AspectRatio(aspectRatio: 1,child:Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: ColorUtil.getColorFromHex("#035F86"),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Icon(
                    widget.icon,
                      size: 16,
                      color: Colors.white,
                    )),
              )),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }

}
