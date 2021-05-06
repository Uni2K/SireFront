/**save() {
  //https://github.com/flutter/flutter/issues/33577

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
    pw.Document doc = pw.Document(author: "Sire", title: "Title");
    final image = await WidgetWraper.fromKey(
      key: widget.pageEditorDataKey,
      pixelRatio: 1.0, //Quality
      // orientation: PdfImageOrientation.topLeft
    );
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Image(image, fit: pw.BoxFit.cover);
        }));
    return await doc.save();
  });
}
save() {
  //https://github.com/flutter/flutter/issues/33577

  Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
    pw.Document doc = pw.Document(author: "Sire", title: "Title");
    final image = await WidgetWraper.fromKey(
      key: widget.pageEditorResultKey,
      pixelRatio: 1.0, //Quality
      // orientation: PdfImageOrientation.topLeft
    );
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Image(image, fit: pw.BoxFit.cover);
        }));
    return await doc.save();
  });


}
ConstrainedBox(
constraints:
BoxConstraints(minWidth: double.infinity),
child: Container(
decoration: BoxDecoration(
boxShadow: [
BoxShadow(
color: Colors.grey.shade400,
offset: Offset(0.0, 3.0), //(x,y)
blurRadius: 3.0,
)
],
color: Colors.white,
borderRadius:
BorderRadius.all(Radius.circular(5))),
padding: EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [
Row(
children: [
Expanded(child: Text("Share", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),)),
ButtonCircleNeutral(
background: true,
icon: Icon(
Icons.close,
color: Colors.grey,
size: 18,
),
onClick: () {}),
],
),
SizedBox(
height: 20,
),

StaggeredGridView.countBuilder(
shrinkWrap: true,
crossAxisCount: gridViewColumns,
itemCount: 7,
itemBuilder: (BuildContext context, int index) => socialMediaWidgets[index],
staggeredTileBuilder: (int index) =>
new StaggeredTile.fit(1),
mainAxisSpacing: 4.0,
crossAxisSpacing: 4.0,
),
SizedBox(height: 20,),
Text("Link zur Seite", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
SizedBox(height: 10,),
TextfieldSelectable()
],
),
),
)



Query(
options: QueryOptions(
document: gql(HelperServer.getAllContent()),
pollInterval: Duration(seconds: 60),
cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
fetchPolicy: FetchPolicy.cacheAndNetwork,
),
builder: (result, {fetchMore, refetch}) {
if (result.hasException) {
return Text(result.exception.toString());
}
if (result.isLoading) {
return SizedBox();
}

return Obx(() => AnimatedOpacity(
opacity: viewModelMain.appLoaded.value ? 1 : 0,
duration: Duration(milliseconds: 1000),
child: Align(
alignment: Alignment.center,
child: Container(
height:
MediaQuery.of(context).size.height * heightPercentage,
child: Stack(
children: [
Align(
key: widget.backgroundKey,
alignment: Alignment.center,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
flex: 20,
child: ListSnappableCombined(
result: result,
scrollController: _headerBackground,
key: widget.headerBKey,
onFocused: () => highlightAnimation(0),
contentType: ContentTypes.Header,
background: true)),
Flexible(
flex: 70,
child: ListSnappableCombined(
onFocused: () => highlightAnimation(1),
result: result,
scrollController: _bodyBackground,
key: widget.bodyBKey,
contentType: ContentTypes.Body,
background: true)),
Flexible(
flex: 10,
child: ListSnappableCombined(
onFocused: () => highlightAnimation(2),
result: result,
scrollController: _footerBackground,
key: widget.footerBKey,
contentType: ContentTypes.Footer,
background: true)),
],
)),
Align(
child: RepaintBoundary(
key: widget.editingKey,
child: PageEditing(
key: widget.previewBackground,
)),
alignment: Alignment.center,
),
Align(
key: widget.contentKey,
alignment: Alignment.center,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
flex: 20,
child: ListSnappableCombined(
onFocused: () => null,
result: result,
key: widget.headerKey,
scrollController: _headerContent,
contentType: ContentTypes.Header,
)),
Flexible(
flex: 70,
child: ListSnappableCombined(
onFocused: () => null,
result: result,
key: widget.bodyKey,
scrollController: _bodyContent,
contentType: ContentTypes.Body,
)),
Flexible(
flex: 10,
child: ListSnappableCombined(
onFocused: () => null,
result: result,
key: widget.footerKey,
scrollController: _footerContent,
contentType: ContentTypes.Footer)),
],
)),
// ...buildNavigationOverlay(context),
],
),
))));
});
}





    //THAT FOCUS SHIT

    updateFocusNodes() {
    List<FocusNode>? focusNodesFooter = widget.footerKey.currentState?.getFocusNodes();
    List<FocusNode>? focusNodesBody =  widget.bodyKey.currentState?.getFocusNodes();
    List<FocusNode>? focusNodesHeader =  widget.headerKey.currentState?.getFocusNodes();
    List<FocusNode> combinedFocusNodes = {
    ...?focusNodesHeader,
    ...?focusNodesBody,
    ...?focusNodesFooter
    }.toList();
    focusNodes = combinedFocusNodes;
    }

    nextFocus(FocusNode focusNode) {
    updateFocusNodes();
    int index = focusNodes.indexOf(focusNode);
    if (focusNodes.length > index + 1) {
    FocusNode nextFocusNode = focusNodes[index + 1];
    nextFocusNode.requestFocus();
    }
    }


    @override
    Widget build(BuildContext context) {


    return Align(
    alignment: Alignment.center,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Flexible(
    flex: 20,
    fit: FlexFit.tight,
    child: PageCombined(
    key:  widget.headerKey,
    content: widget.header?.content,
    contentType: ContentTypes.Header,
    isDisable: false,
    onNextFocus: (_)=>nextFocus(_),
    background: false,
    )),
    Flexible(
    flex: 70,
    fit: FlexFit.tight,
    child: PageCombined(
    key:  widget.bodyKey,
    content: widget.body?.content,
    contentType: ContentTypes.Body,
    isDisable: false,
    background: false,
    onNextFocus: (_)=>nextFocus(_),
    )),
    Flexible(
    flex: 10,
    fit: FlexFit.tight,
    child: PageCombined(
    key:  widget.footerKey,
    content: widget.footer?.content,
    contentType: ContentTypes.Footer,
    isDisable: false,
    onNextFocus: (_)=>nextFocus(_),
    background: false,
    )),
    ],
    ));
    }








**/
