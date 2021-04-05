import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sire/constants/constant_dimensions.dart';
import 'package:sire/helper/helper_server.dart';
import 'package:sire/widgets/editor/page_combined.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

enum ContentTypes { Header, Body, Footer }

class ListSnappableCombined extends StatefulWidget {
  ListSnappableCombined(
      {Key? key, this.scrollController, required this.contentType, this.background = false})
      : super(key: key);

  final ContentTypes contentType;
  final ScrollController? scrollController;
  final bool background;

  @override
  _ListSnappableCombinedState createState() => _ListSnappableCombinedState();
}

class _ListSnappableCombinedState extends State<ListSnappableCombined> {
  @override
  Widget build(BuildContext context) {
    List<PageCombined> contentPages = List.empty(growable: true);


    return Query(
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }


        final List content = result.data ? [getDataSelector()];
        for (var item in content) {
          contentPages.add(PageCombined(content: item["content"],
            key: GlobalKey<PageCombinedState>(),
            background: widget.background,
            contentType: widget.contentType,));
        }


        return ScrollSnapList(
          scrollDirection: Axis.horizontal,
          itemCount: content.length,
          listController: widget.scrollController,
          initialIndex: (content.length / 2),

          itemBuilder: (context, index) {
            return contentPages[index];
          },
          itemSize: (((MediaQuery
              .of(context)
              .size
              .height * heightPercentage) /
              sqrt(2))),
          onItemFocus: (int) {
            (contentPages[int].key as GlobalKey<PageCombinedState>).currentState?.setState(() {
              ( contentPages[int].key as GlobalKey<PageCombinedState>).currentState?.widget.isDisable=false;
            });
          },
        );
      },
      options: QueryOptions(
        document: gql(getQuery()),
        // this is the query string you just created
        variables: {
          'nRepositories': 50,
        },
        pollInterval: Duration(seconds: 10),
      ),
    );
  }

  String getQuery() {
    switch (widget.contentType) {
      case ContentTypes.Header:
        return HelperServer.getHeaders();
      case ContentTypes.Body:
        return HelperServer.getBodies();
      case ContentTypes.Footer:
        return HelperServer.getFooters();
    }
  }

  getDataSelector() {
    switch (widget.contentType) {
      case ContentTypes.Header:
        return "headers";
      case ContentTypes.Body:
        return "bodies";
      case ContentTypes.Footer:
        return "footers";
    }
  }
}
