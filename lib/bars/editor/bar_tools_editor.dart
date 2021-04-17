import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_editor_data.dart';
import 'package:sire/screens/screen_editor_result.dart';
import 'package:sire/screens/screen_editor_template.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_circle_neutral.dart';

class BarToolsEditor extends StatefulWidget {
  BarToolsEditor({Key? key, required this.screenEditorTemplateKey,required this.screenEditorDataKey, required this.screenEditorResultKey}) : super(key: key);

  final GlobalKey<ScreenEditorTemplateState> screenEditorTemplateKey;
  final GlobalKey<ScreenEditorDataState> screenEditorDataKey;
  final GlobalKey<ScreenEditorResultState> screenEditorResultKey;



  @override
  _BarToolsEditorState createState() => _BarToolsEditorState();
}

class _BarToolsEditorState extends State<BarToolsEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: navigationBarBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(children: [getContent()],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget getContent(){
    ViewModelMain viewModelMain=Get.put(ViewModelMain());
    switch(viewModelMain.currentEditorStep.value){
      case EditorSteps.Template:
        return ButtonCircleNeutral(icon: Icon(Icons.undo, color: Colors.white,size: 18,), onClick: ()=>widget.screenEditorTemplateKey.currentState!.reset());
      case EditorSteps.Data:
        return ButtonCircleNeutral(icon: Icon(Icons.arrow_back, color: Colors.white,size: 18,), onClick: (){
          viewModelMain.currentEditorStep.value=EditorSteps.Template;
        });
      case EditorSteps.Result:
        return Container();




    }


  }




}
