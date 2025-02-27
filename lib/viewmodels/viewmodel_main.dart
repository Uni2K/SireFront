import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:get/get.dart';
import 'package:sire/objects/dto_configuration.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/widgets/page/interactive_page.dart';
import 'package:sire/widgets/page/page_prototype.dart';
import 'package:sire/widgets/tiles/list_tile_editor.dart';

class ViewModelMain extends GetxController {

  //Keys
  GlobalKey<InteractivePageState>? interactivePageKey;
  GlobalKey<PagePrototypeState>? pagePrototypeKey;
  GlobalKey? repaintKey;


  //View related
  Rx<ShowingContainer> currentContainer = ShowingContainer.EditingTool.obs;
  Rx<int> currentHeader = 0.obs;
  Rx<QuillController> currentController = QuillController.basic().obs;
  RxList<TileContent> editorTiles = List<TileContent>.empty(growable: true).obs;

  //General
  Rx<DTOConfiguration> configuration = DTOConfiguration.empty().obs;
  RxBool isCurrentlyTouched = false.obs;
  RxBool isEditingStarted=false.obs; //as soon as a controller is set
  RxBool resetTrigger=false.obs;
  //Data
  RxList<ByteData> signatures=List<ByteData>.empty(growable: true).obs;


  ///saves the initial content for fast access
  void setServerContent(Map<String, dynamic>? data) {

    Map<String, dynamic> config = data?["Configuration"];
    DTOConfiguration dtoConfiguration = DTOConfiguration.empty();
    dtoConfiguration.darkmode = config["darkmode"];
    dtoConfiguration.zoom = config["zoom"];
    dtoConfiguration.zoomPosition = config["zoom_position"];
    dtoConfiguration.scrollbar = config["scrollbar"];
    dtoConfiguration.scrollbarPosition = config["scrollbar_position"];
    dtoConfiguration.fonts = config["fonts"];
    dtoConfiguration.fontsValue = config["fonts_value"];
    dtoConfiguration.headers = config["headers"];
    dtoConfiguration.headerIndex = config["header_index"];
    dtoConfiguration.sharing = config["sharing"];
    dtoConfiguration.sharingProviders =
        (config["sharing_providers"] as List<Object?>).cast<String>();
    dtoConfiguration.pageLink = config["page_link"];
    dtoConfiguration.pollingUpdates = config["polling_updates"];
    dtoConfiguration.pollingFrequency = config["polling_frequency"];
    configuration.value = dtoConfiguration;
  }

  void updateQuillController(QuillController controller) {

    if(!isEditingStarted.value){
      //no userinteraction yet
      isEditingStarted.value=true;
      currentContainer.value=ShowingContainer.EditingTool;
    }
    currentController.value = controller;
  }
}
