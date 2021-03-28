import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';

class PageBackground extends StatefulWidget {
  PageBackground({Key? key}) : super(key: key);

  @override
  _PageBackgroundState createState() => _PageBackgroundState();

}

class _PageBackgroundState extends State<PageBackground> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.symmetric(horizontal: spacePages, vertical: spacePages),
        width: ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2))-spacePages*2,
        decoration:
             BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.01),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              )
           );
  }
}
