import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/screens/screen_main.dart';
import 'package:sire/screens/screen_test.dart';

import 'utils/util_server.dart';

void main() {
  final HttpLink link = HttpLink(
    SERVER_URL,
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  runApp(SireApp(client: client));
}

class SireApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const SireApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          shortcuts: ignoredNavigationShortcuts(),
          title: 'Sire',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              toggleableActiveColor: primaryColor,
              checkboxTheme:
                  CheckboxThemeData(
                      shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      overlayColor: null,
                      fillColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected) && !states.contains(MaterialState.disabled)) {
                    return primaryColor; // the color when checkbox is selected;
                  }
                  return buttonBackgroundColor; //the color when checkbox is unselected;
                },
              )),
              textSelectionTheme:
                  TextSelectionThemeData(selectionColor: selectionColor)),
          home: ScreenMain(),
        ));
  }

  Map<ShortcutActivator, Intent> ignoredNavigationShortcuts() {
    Map<ShortcutActivator, Intent> shortcuts =
        Map.from(WidgetsApp.defaultShortcuts);
    shortcuts.removeWhere((key, value) {
      return key.triggers?.first.keyLabel ==
              LogicalKeyboardKey.arrowUp.keyLabel ||
          key.triggers?.first.keyLabel ==
              LogicalKeyboardKey.arrowDown.keyLabel ||
          key.triggers?.first.keyLabel ==
              LogicalKeyboardKey.arrowLeft.keyLabel ||
          key.triggers?.first.keyLabel ==
              LogicalKeyboardKey.arrowRight.keyLabel ||
          key.triggers?.first.keyLabel == LogicalKeyboardKey.space.keyLabel;
      //  || key.triggers.first.keyLabel == LogicalKeyboardKey.tab.keyLabel;
    });

    return shortcuts;
  }
}
