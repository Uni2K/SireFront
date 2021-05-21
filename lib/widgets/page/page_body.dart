import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/utils/util_size.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/input/inputfield_quill.dart';

class PageBody extends StatefulWidget {
  PageBody({Key? key, this.content, this.onNextFocus}) : super(key: key);

  final String? content;

  final ValueChanged<FocusNode>? onNextFocus;

  @override
  PageBodyState createState() => PageBodyState();
}

class PageBodyState extends State<PageBody> {
  List<FocusNode> focusNodes = List.empty(growable: true);
  late QuillController _controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        ViewModelMain viewModelMain = Get.put(ViewModelMain());
        viewModelMain.updateQuillController(_controller);
      }
    });
    _controller = QuillController(
        document: Document(), selection: TextSelection.collapsed(offset: 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets getPadding() {
    double width =UtilSize.getPageWidth(context);

    double paddingTLR = paperMarginTLRRelative * width;
    double paddingB = paperMarginBRelative * width;
    return EdgeInsets.only(
        left: paddingTLR, right: paddingTLR, bottom: paddingB);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Container(
              padding: getPadding(),
              child: InputfieldQuill(
                initialContent:
                    """Sehr geehrte Damen und Herren, bitte lesen Sie weiter!

Das Problem bei dieser Anredeform ist folglich, dass wir keinen konkreten Ansprechpartner meinen, sondern pauschal alles und jeden anschreiben. Dabei kommt es natürlich mitunter vor, dass ein Unternehmen ausschließlich aus Damen oder eben Herren besteht oder es eine bestimmte Hierarchie zu beachten gilt. Gibt es einen Chef und eine Sekräterin, nennen wir den Mann selbstverständlich vorab. Die Formulierung wäre also:“Sehr geehrter Herr Müller, sehr geehrte Frau Mustermann,…“
Haben wir es beispielsweise mit einer Personalchefin zu tun und schreiben nur im Subtext einen Personaler mit an, sollten wir allerdings auf „Sehr geehrte Frau Mustermann, sehr geehrter Herr Müller,…“ zurückgreifen.\n""",
                style: TextStyle(),
                placeholding: true,
                readOnly: false,
              )))
    ]);
  }
}
