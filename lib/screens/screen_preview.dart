import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
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

  GlobalKey pagePreviewKey=new GlobalKey();

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
                child:  RepaintBoundary(
                key: widget.pagePreviewKey,child: PagePreview(
                    footer: widget.footerKey.currentState?.getContent(),
                    header: widget.headerKey.currentState?.getContent(),
                    body: widget.bodyKey.currentState?.getContent()))),
            Align(
              child: Container(
                  width: MediaQuery.of(context).size.height *
                      heightPercentage /
                      sqrt(2),
                  color:previewBackgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonTarget(
                        icon: Icons.cloud_download_outlined,
                        text: "Downloaden",
                        onClick:(){save();},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTarget(
                        onClick: (){},
                        icon: Icons.local_printshop_rounded,
                        text: "Drucken",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTarget(
                        onClick: (){},
                        icon: Icons.share_rounded,
                        text: "Teilen",
                      ),
                    ],
                  )),
              alignment: Alignment.centerRight,
            )
          ],
        ));
  }
  save() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format)  async{
      final doc = pw.Document(author: "Sire", title: "Title");

      final image = await WidgetWraper.fromKey(
        key: widget.pagePreviewKey,
         pixelRatio: 1.0, //Quality
       // orientation: PdfImageOrientation.topLeft
      );

      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,

          build: (pw.Context context) {
            return
              pw.Image(image, fit: pw.BoxFit.cover);

          }));

      return doc.save();
    });
  }
}
