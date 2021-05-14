import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_circle_socialmedia.dart';
import 'package:sire/widgets/buttons/button_download.dart';
import 'package:sire/widgets/misc/arrow_ready.dart';
import 'package:sire/widgets/misc/text_thanks.dart';
import 'package:sire/widgets/misc/textfield_selectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ContainerFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> socialMediaWidgets = getSocialMediaWidgets();

    return Column(
      children: [
        Flexible(
            child: FractionallySizedBox(
                widthFactor: 0.7,
                heightFactor: 0.95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextThanks(),
                    Flexible(
                        child: Text(
                      "dass Sie Sire verwendet haben.\nErzählen Sie gerne Ihren Freunden/-innen davon.",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColor,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Flexible(
                        child: SizedBox(
                            width: 400,
                            child: Wrap(
                                runSpacing: 30,
                                spacing: 30,
                                alignment: WrapAlignment.center,
                                children: socialMediaWidgets))),
                  ],
                ))),
        Expanded(
            child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Align(
                          alignment: Alignment.centerLeft, child: ArrowReady()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        ButtonDownload(
                          text: "Herunterladen",
                          icon: FontAwesomeIcons.filePdf,
                          onClick: () =>save(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("oder"),
                        SizedBox(
                          width: 10,
                        ),
                        ButtonDownload(
                          icon: FontAwesomeIcons.print,
                          text: 'Drucken',
                          onClick: () => null,
                        ),
                        Spacer(),
                        IntrinsicWidth(
                            child: TextfieldSelectable(
                          text: "www.sire.com/3423324",
                        ))
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )))
      ],
    );
  }

  save() {
    //https://github.com/flutter/flutter/issues/33577

    print("start1");
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      ViewModelMain viewModelMain = Get.put(ViewModelMain());

      pw.Document doc = pw.Document(author: "Sire", title: "Title");
      print("in1");

      final image = await WidgetWraper.fromKey(
        key: viewModelMain.pagePrototypeKey??GlobalKey(),
        pixelRatio: 3.0, //Quality
        // orientation: PdfImageOrientation.topLeft
      );
      print("in2");

      doc.addPage(pw.Page(
        margin: pw.EdgeInsets.all(0),
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Image(image, fit: pw.BoxFit.cover);
          }));
      print("in3");

      return await doc.save();
    });
    print("start2");


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
