import 'package:flutter/material.dart';

abstract class HeaderPrototype extends StatelessWidget {

  final bool readOnly;

  const HeaderPrototype({Key? key, required this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
