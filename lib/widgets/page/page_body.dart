import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/input/inputfield_page.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class PageBody extends StatefulWidget {
  PageBody(
      {Key? key, this.content,this.onNextFocus})
      : super(key: key);

  final String? content;

  final ValueChanged<FocusNode>? onNextFocus;

  @override
  PageBodyState createState() => PageBodyState();
}

class PageBodyState extends State<PageBody> {
  List<FocusNode> focusNodes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    double widthViewer = MediaQuery
        .of(context)
        .size
        .width * viewerWidth;
    double widthPage = min(
        MediaQuery
            .of(context)
            .size
            .height * heightPercentage,
        widthViewer * 0.9);

    return Container(child: InputfieldPage(
        focusNode: FocusNode(),
        onSubmitted: () {

        },
        hint: """Sehr geehrte Damen und Herren, bitte lesen Sie weiter!

Das Problem bei dieser Anredeform ist folglich, dass wir keinen konkreten Ansprechpartner meinen, sondern pauschal alles und jeden anschreiben. Dabei kommt es natürlich mitunter vor, dass ein Unternehmen ausschließlich aus Damen oder eben Herren besteht oder es eine bestimmte Hierarchie zu beachten gilt. Gibt es einen Chef und eine Sekräterin, nennen wir den Mann selbstverständlich vorab. Die Formulierung wäre also:“Sehr geehrter Herr Müller, sehr geehrte Frau Mustermann,…“
Haben wir es beispielsweise mit einer Personalchefin zu tun und schreiben nur im Subtext einen Personaler mit an, sollten wir allerdings auf „Sehr geehrte Frau Mustermann, sehr geehrter Herr Müller,…“ zurückgreifen.""",
        style:Style()),);
  }
}
