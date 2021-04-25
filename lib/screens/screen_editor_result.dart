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

class ScreenEditorResult extends StatefulWidget {

  ScreenEditorResult(
      {Key? key})
      : super(key: key);

  GlobalKey pageEditorResultKey = new GlobalKey();

  @override
  ScreenEditorResultState createState() => ScreenEditorResultState();
}

class ScreenEditorResultState extends State<ScreenEditorResult> {



  @override
  Widget build(BuildContext context) {
    ViewModelMain viewModelMain = Get.put(ViewModelMain());


    double containerWidth=calculateShareWidth();
    double slope=((0.9-0.55)/(400-688));
    double shareSectionWidthFraction=(slope*containerWidth+(0.55-slope*688)).clamp(0.55,0.90);
    int gridViewColumns=(shareSectionWidthFraction>0.85)?2:((shareSectionWidthFraction>0.80)?3:((shareSectionWidthFraction>0.6)?4:4));

   List<Widget> socialMediaWidgets= getSocialMediaWidgets();

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
                    key: widget.pageEditorResultKey,
                    child: PageData(
                        footer: viewModelMain.footer,
                        header:  viewModelMain.header,
                        body:  viewModelMain.body))),
            Align(
              child: Container(
                  width: containerWidth,
                  padding: EdgeInsets.all(20),
                  child: FractionallySizedBox(
                      widthFactor:shareSectionWidthFraction ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: ButtonTarget(
                                icon: Icons.arrow_circle_down,
                                text: "Herunterladen",
                                onClick: (){
                                  print("save start");
                                  save();
                                  print("save end");

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
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text("Share", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),)),
                                      ButtonCircleNeutral(
                                        background: true,
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

                                  StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    crossAxisCount: gridViewColumns,
                                    itemCount: 7,
                                    itemBuilder: (BuildContext context, int index) => socialMediaWidgets[index],
                                    staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.fit(1),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                  ),
                                  SizedBox(height: 20,),
                                  Text("Link zur Seite", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                                  SizedBox(height: 10,),
                                  TextfieldSelectable()
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
    //https://github.com/flutter/flutter/issues/33577

      Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      pw.Document doc = pw.Document(author: "Sire", title: "Title");
      final image = await WidgetWraper.fromKey(
        key: widget.pageEditorResultKey,
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
