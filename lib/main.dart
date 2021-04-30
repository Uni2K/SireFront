import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/screens/screen_main.dart';

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
          title: 'Sire',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: ScreenMain(),
        ));
  }
}
