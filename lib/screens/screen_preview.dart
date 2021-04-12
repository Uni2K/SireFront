import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_target.dart';
import 'package:sire/widgets/editor/page_editing.dart';
import 'package:sire/widgets/editor/page_preview.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ScreenPreview extends StatefulWidget {
  final GlobalKey<ListSnappableCombinedState> footerKey, headerKey, bodyKey;

  ScreenPreview(
      {Key? key,
      required this.footerKey,
      required this.headerKey,
      required this.bodyKey})
      : super(key: key);

  GlobalKey pagePreviewKey = new GlobalKey();

  @override
  ScreenPreviewState createState() => ScreenPreviewState();
}

class ScreenPreviewState extends State<ScreenPreview> {
  @override
  Widget build(BuildContext context) {
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
                    key: widget.pagePreviewKey,
                    child: PagePreview(
                        footer: widget.footerKey.currentState?.getContent(),
                        header: widget.headerKey.currentState?.getContent(),
                        body: widget.bodyKey.currentState?.getContent()))),
            Align(
              child: Container(
                  width: MediaQuery.of(context).size.height *
                      heightPercentage /
                      sqrt(2) *
                      0.5,
                  padding: EdgeInsets.all(20),
                  color: previewBackgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: ButtonTarget(
                            icon: Icons.cloud_download_outlined,
                            text: "Herunterladen ",
                            onClick: () {
                              save();
                            },
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          ButtonTarget(
                            onClick: () {},
                            icon: Icons.local_printshop_rounded,
                            text: null,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text("Share")),
                                  ButtonCircleNeutral(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                      onClick: () {}),
                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              alignment: Alignment.centerRight,
            )
          ],
        ));
  }

  save() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document(author: "Sire", title: "Title");

      final image = await WidgetWraper.fromKey(
        key: widget.pagePreviewKey,
        pixelRatio: 1.0, //Quality
        // orientation: PdfImageOrientation.topLeft
      );

      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Image(image, fit: pw.BoxFit.cover);
          }));

      return doc.save();
    });
  }
}
