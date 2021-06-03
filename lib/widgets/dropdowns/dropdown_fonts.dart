import 'package:flutter/material.dart';

class DropdownFonts extends StatefulWidget {
  DropdownFonts({Key? key, required this.probeText, required this.onFontSelected}) : super(key: key);
  final String probeText;
  final ValueChanged<String> onFontSelected;
  @override
  _DropdownFontsState createState() => _DropdownFontsState();
}

class _DropdownFontsState extends State<DropdownFonts> {
  int _value = 0;
  late List<String> fontFamilies;

  @override
  void initState() {
    super.initState();
    fontFamilies = _getFontFamilies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _value,
     isDense: true,
      style: TextStyle(color: Colors.black),
      items: fontFamilies.map<DropdownMenuItem<int>>((stringvalue) {
        return DropdownMenuItem<int>(
          value: fontFamilies.indexOf(stringvalue),
          child: Text(
            widget.probeText.length < 5 ? "Max Mustermann" : widget.probeText,
            style: TextStyle(fontSize: 17, fontFamily: stringvalue),
          ),
        );
      }).toList(),
      hint: null,
      onChanged: (int? value) {
        setState(() {
          _value = value ?? 0;
          widget.onFontSelected.call(fontFamilies[_value]);
        });
      },
    );
  }

  List<String> _getFontFamilies() {
    List<String> families = List.empty(growable: true);
    families.add("Arty");
    families.add("AlexBrush");
    families.add("Arabella");
    families.add("Otto");
    families.add("Quig");
    families.add("Sacramento");
    families.add("Stalemate");
    families.add("Tower");
    families.add("Berkshire");

    return families;
  }
}
