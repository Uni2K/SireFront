import 'package:flutter/widgets.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:get/get.dart';
import 'package:sire/objects/dto_configuration.dart';
import 'package:sire/objects/dto_header.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/widgets/page/interactive_page.dart';

class ViewModelMain extends GetxController {
  GlobalKey<InteractivePageState>? interactivePageKey;
  Rx<ShowingContainer> currentContainer = ShowingContainer.HeaderSelection.obs;
  RxList<DTOHeader> headerCached = List<DTOHeader>.empty(growable: true).obs;
  Rx<DTOConfiguration> configuration = DTOConfiguration.empty().obs;
  Rx<DTOHeader> currentHeader=DTOHeader.dummy().obs;

  Rx<QuillController> currentController=QuillController.basic().obs;
  RxBool editingStarted = true.obs;

  ///saves the initial content for fast access
  void setServerContent(Map<String, dynamic>? data) {
    List<DTOHeader> tempH = List.empty(growable: true);
    for (var item in data!["headers"] ?? []) {
      tempH.add(DTOHeader(item["content"], item["name"]));

    }
    headerCached.value = tempH;
    if(currentHeader.value.content==null && headerCached.length>0)currentHeader.value=headerCached.first;

    Map<String, dynamic> config = data["Configuration"];
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
    dtoConfiguration.sharingProviders = (config["sharing_providers"] as List<Object?>).cast<String>();
    dtoConfiguration.pageLink = config["page_link"];
    dtoConfiguration.pollingUpdates = config["polling_updates"];
    dtoConfiguration.pollingFrequency = config["polling_frequency"];
    configuration.value=dtoConfiguration;
  }
}
