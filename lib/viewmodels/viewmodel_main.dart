import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sire/objects/page_constituent.dart';
import 'package:sire/widgets/editor/page_combined.dart';
import 'package:sire/widgets/interactive_page.dart';
import 'package:sire/widgets/misc/interactive_viewer_adjusted.dart';

enum EditorSteps { Template, Data, Result }

class ViewModelMain extends GetxController {
  Rx<EditorSteps> currentEditorStep = EditorSteps.Template.obs;
  RxBool appLoaded = false.obs;

  PageConstituent? footer, body, header;
  GlobalKey<InteractivePageState>? interactivePageKey;



  void setInteractivePageKey(GlobalKey<InteractivePageState> globalKey) {
    interactivePageKey=globalKey;
  }


}
