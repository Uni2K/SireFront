import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sire/utils/util_text.dart';

void main() {

  /**
   * New line break counts to same row
   */
  test('Total line number matching', () {
    String text = "test \n test \n test";
    expect(UtilText.getTotalLineNumber(text), 3);

    text = "test \n test \n test \n";
    expect(UtilText.getTotalLineNumber(text), 3);

    text = "test";
    expect(UtilText.getTotalLineNumber(text), 1);

    text = "test\n\n";
    expect(UtilText.getTotalLineNumber(text), 2);

  });

  /**
   * Cursor Position 0 -> before the 0th char -> can also be before linebreak
   * So every line has 1 sign more which is the line break identifier
   */
  test('Line number based on cursor position', () {
    List<String> toTest = List.empty(growable: true);
    toTest.add("line1\nline2\nline3\n\n");
    toTest.add('''line1
line2
line3
'''); //Damn, what is dart doooinng? https://github.com/dart-lang/language/issues/559

    for (int i = 0; i < toTest.length; i++) {
      String text = toTest[i];
      expect(UtilText.getLineNumber(text, 0), 0); //beginning of the first line
      expect(UtilText.getLineNumber(text, 5), 0); //end of the first line
      expect(UtilText.getLineNumber(text, 6), 1); //start of the second line
      expect(UtilText.getLineNumber(text, 11), 1); //end of the second line
      expect(UtilText.getLineNumber(text, 12), 2); //start third line
      expect(UtilText.getLineNumber(text, 18), 3); //start third line

    }
  });

  test('Line based on cursor position', () {
    String text = "line1\nline2\nline3\n\n";

    expect(UtilText.getLine(text, 0), "line1\n");
    expect(UtilText.getLine(text, 6), "line2\n");
    expect(UtilText.getLine(text, 12), "line3\n");
    expect(UtilText.getLine(text, 15), "line3\n");
    expect(UtilText.getLine(text, 16), "line3\n");
    expect(UtilText.getLine(text, 18), "\n");


  });


  test('Select a specific row', () {
    String text = "line1\nline2\nline3\n\n";

    expect(UtilText.selectLine(text:text, lineNumber: 0), TextSelection(baseOffset: 0,extentOffset: "line1".length));
    expect(UtilText.selectLine(text:text,lineNumber: 1), TextSelection(baseOffset: "line1\n".length,extentOffset: "line1\nline2".length));
    expect(UtilText.selectLine(text:text,lineNumber: 2), TextSelection(baseOffset: "line1\nline2\n".length,extentOffset: "line1\nline2\nline3".length));
    expect(UtilText.selectLine(text:text, lineNumber:3), TextSelection.collapsed(offset:  "line1\nline2\nline3\n".length));

  });





}
