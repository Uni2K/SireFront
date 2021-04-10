import 'package:flutter/material.dart';

class ButtonTarget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClick;

  const ButtonTarget({Key? key, required this.icon, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
              overlayColor: MaterialStateProperty.all<Color>(Colors.white38),
            ),
            onPressed: ()=>onClick(),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            )));
  }
}
