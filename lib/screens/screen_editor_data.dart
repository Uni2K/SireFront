import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_circle_socialmedia.dart';
import 'package:sire/widgets/buttons/button_target.dart';
import 'package:sire/widgets/editor/page_editing.dart';
import 'package:sire/widgets/editor/page_data.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sire/widgets/misc/textfield_selectable.dart';

class ScreenEditorData extends StatefulWidget {
  ScreenEditorData({Key? key}) : super(key: key);

  GlobalKey pageEditorDataKey = new GlobalKey();

  @override
  ScreenEditorDataState createState() => ScreenEditorDataState();
}

class ScreenEditorDataState extends State<ScreenEditorData> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = calculateShareWidth();
    double slope = ((0.9 - 0.55) / (400 - 688));
    double shareSectionWidthFraction =
        (slope * containerWidth + (0.55 - slope * 688)).clamp(0.55, 0.90);


    ViewModelMain viewModelMain = Get.put(ViewModelMain());

    return Container(
        height: MediaQuery.of(context).size.height * heightPercentage,
        child: Stack(
          children: [
            Align(
              child: RepaintBoundary(child: PageEditing()),
              alignment: Alignment.center,
            ),
            Align(
                child: RepaintBoundary(
                    key: widget.pageEditorDataKey,
                    child: PageData(
                        footer: viewModelMain.footer,
                        header: viewModelMain.header,
                        body: viewModelMain.body))),
            Align(
              child: Container(
                  width: containerWidth,
                  padding: EdgeInsets.all(20),
                  child: FractionallySizedBox(
                      widthFactor: shareSectionWidthFraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: double.infinity),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      offset: Offset(0.0, 3.0), //(x,y)
                                      blurRadius: 3.0,
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.all(20),
                              
                            ),
                          )
                        ],
                      ))),
              alignment: Alignment.centerRight,
            )
          ],
        ));
  }

  double calculateShareWidth() {
    double pageWidth =
        ((MediaQuery.of(context).size.height * heightPercentage) / sqrt(2)) -
            spacePages * 2;
    double totalWidth = MediaQuery.of(context).size.width;
    double remainingWidth = totalWidth - pageWidth;
    double remainingWidthPerSide = remainingWidth / 2.0;
    return remainingWidthPerSide;
  }

  save() {
    //https://github.com/flutter/flutter/issues/33577

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      pw.Document doc = pw.Document(author: "Sire", title: "Title");
      final image = await WidgetWraper.fromKey(
        key: widget.pageEditorDataKey,
        pixelRatio: 1.0, //Quality
        // orientation: PdfImageOrientation.topLeft
      );
      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Image(image, fit: pw.BoxFit.cover);
          }));
      return await doc.save();
    });
  }

}
