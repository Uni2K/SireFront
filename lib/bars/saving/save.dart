import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_color.dart';

class Save extends StatefulWidget {
  Save({Key? key, required this.onClick}) : super(key: key);
  final VoidCallback onClick;
  bool isLoading = false;

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> with TickerProviderStateMixin {
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
            setState(() {
              widget.isLoading = true;
            });
          },
          child: Row(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: !widget.isLoading?0:200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale:  animation,
                    child: child,
                    //  turns: _animation,
                  );
                },
                child: getAnimationContent(),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Speichern",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }

  getAnimationContent() {
    return AspectRatio(
      key: UniqueKey(),
      aspectRatio: 1,
      child: IntrinsicWidth(
        child: widget.isLoading
            ? Container(
                padding: EdgeInsets.all(9),
                child: CircularProgressIndicator(

                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ))
            : Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: ColorUtil.getColorFromHex("#035F86"),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Text(".pdf",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500))),
              ),
      ),
    );
  }
}
