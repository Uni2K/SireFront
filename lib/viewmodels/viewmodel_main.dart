import 'package:get/get.dart';
import 'package:sire/widgets/editor/page_combined.dart';




enum EditorSteps{
  Template, Data, Result
}
class ViewModelMain extends GetxController {


  Rx<EditorSteps> currentEditorStep = EditorSteps.Template.obs;
  RxBool appLoaded = false.obs;

  PageCombined? footer,body,header;



}
