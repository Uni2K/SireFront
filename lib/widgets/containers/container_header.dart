import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_color.dart';
import 'package:sire/utils/util_server.dart';
import 'package:sire/widgets/lists/list_snappable_combined.dart';

class ContainerHeader extends StatefulWidget {
  ContainerHeader({Key? key}) : super(key: key);

  @override
  _ContainerHeaderState createState() => _ContainerHeaderState();
}

class _ContainerHeaderState extends State<ContainerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.topCenter,
            child: Query(
                options: QueryOptions(
                  document: gql(UtilServer.getInitialContent()),
                  pollInterval: Duration(seconds: 60),
                  cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
                  fetchPolicy: FetchPolicy.cacheAndNetwork,
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    print(result.exception?.linkException.toString());
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return SizedBox();
                  }
                  return ListSnappableCombined(
                    onFocused: () => null,
                    result: result,
                  );
                })));
  }
}
