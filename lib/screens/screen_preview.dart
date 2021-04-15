import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';
import 'package:sire/widgets/buttons/button_circle_socialmedia.dart';
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
                  width: calculateShareWidth(),
                  padding: EdgeInsets.all(20),
                  child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: ButtonTarget(
                                icon: Icons.cloud_download_outlined,
                                text: "Herunterladen",
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GridView.count(
                                    crossAxisCount: 4,
                                    shrinkWrap: true,
                                    childAspectRatio: 1,
                                    children: getSocialMediaWidgets(),
                                  )
                                ],
                              ),
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

  List<Widget> getSocialMediaWidgets() {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(ButtonCircleSocialmedia(
      type: Types.Twitter,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Facebook,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Reddit,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Skype,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Whatsapp,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Messenger,
    ));
    widgets.add(ButtonCircleSocialmedia(
      type: Types.Telegram,
    ));

    return widgets;
  }
}
