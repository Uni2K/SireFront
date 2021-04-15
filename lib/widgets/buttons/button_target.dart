import 'package:flutter/material.dart';

class ButtonTarget extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onClick;

  const ButtonTarget(
      {Key? key, required this.icon, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: TextButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(5),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
            onPressed: () => onClick(),
            child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.black, size: 25),
                    if (text != null)
                      SizedBox(
                        width: 20,
                      ),
                    if (text != null)
                      Expanded(
                          child: Center(
                        child: Text(text ?? "",
                            style:
                                TextStyle(fontSize: 17, color: Colors.black)),
                      )),
                  ],
            )));
  }
}
