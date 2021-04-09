import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/widgets/buttons/button_target.dart';
import 'package:sire/widgets/editor/page_editing.dart';
import 'package:sire/widgets/editor/page_preview.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class ScreenPreview extends StatelessWidget {
  final GlobalKey<ListSnappableCombinedState> footerKey, headerKey, bodyKey;

  const ScreenPreview(
      {Key? key,
      required this.footerKey,
      required this.headerKey,
      required this.bodyKey})
      : super(key: key);

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
                child: PagePreview(
                    footer: footerKey.currentState?.getContent(),
                    header: headerKey.currentState?.getContent(),
                    body: bodyKey.currentState?.getContent())),
            Align(
              child: Container(
                  width: MediaQuery.of(context).size.height *
                      heightPercentage /
                      sqrt(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonTarget(
                        icon: Icons.cloud_download_outlined,
                        text: "Downloaden",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonTarget(
                        icon: Icons.local_printshop_rounded,
                        text: "Drucken",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonTarget(
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
}
