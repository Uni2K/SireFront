import 'package:flutter/material.dart';

class PickerColor extends StatefulWidget {
  final Function onSelectColor;
  final List<Color> availableColors;
  final Color initialColor;
  final bool circleItem;

  PickerColor(
      {required this.onSelectColor,
        required this.availableColors,
        required this.initialColor,
        this.circleItem = true});

  @override
  _PickerColorState createState() => _PickerColorState();
}

class _PickerColorState extends State<PickerColor> {
  // This variable used to determine where the checkmark will be
  late Color _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 17,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: widget.availableColors.length,
        itemBuilder: (context, index) {
          final itemColor = widget.availableColors[index];
          return InkWell(
            onTap: () {
              widget.onSelectColor(itemColor);
              setState(() {
                _pickedColor = itemColor;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: itemColor,
                  shape: widget.circleItem == true
                      ? BoxShape.circle
                      : BoxShape.rectangle,),
              child: itemColor == _pickedColor
                  ? Center(
                child: Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                ),
              )
                  : Container(),
            ),
          );
        },
    );

  }
}
