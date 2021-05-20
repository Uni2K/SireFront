import 'package:flutter/material.dart';

class TileAddSignature extends StatelessWidget {
  final VoidCallback onFinish;

  const TileAddSignature({Key? key, required this.onFinish}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(
            width: 5,
          ),
          Text("Unterschrift hinzufügen")
        ],
      ),
    );
  }
}
