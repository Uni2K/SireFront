import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/viewmodels/viewmodel_main.dart';
import 'package:sire/widgets/buttons/button_go.dart';
import 'package:sire/widgets/logos/logo_createdby.dart';
import 'package:sire/widgets/logos/logo_sire.dart';

class ContainerWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.95,
        child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LogoSire(),
        SizedBox(
          height: 100,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Erstellen Sie jetzt Ihr:",
                style: TextStyle(fontSize: 20, color: buttonTextColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Notiz Anschreiben Kündigung Bewerbungsschreiben",
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    fontSize: 30, color: navigationBarBackgroundColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        ButtonGo(
          onClick: () {
            ViewModelMain vm = Get.put(ViewModelMain());
            vm.currentContainer.value = ShowingContainer.HeaderSelection;
          },
          text: "Los gehts",
        ),
        Spacer(),
        LogoCreatedby()
      ],
    ));
  }
}
