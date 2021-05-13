import 'package:flutter/material.dart';

class UtilText {
  static int getTotalLineNumber(String text) {
    List<String> lines = text.split("\n");
    if (lines.length > 0) {
      if (lines.last.isEmpty) lines.removeLast();
    }
    return lines.length;
  }

  static int getLineNumber(String text, int cursorPosition) {
    List<String> lines = text.split("\n");
    String searchedContent = "";

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      if (i != lines.length) line += "\n";
      if (line.isEmpty && cursorPosition == searchedContent.length + 2) {
        return i;
      }
      if (cursorPosition < line.length + searchedContent.length) {
        return i;
      }

      searchedContent += line;
    }
    return -1;
  }

  static String? getLine(String text, int cursorPosition) {
    int lineNumber = getLineNumber(text, cursorPosition);
    if(lineNumber==-1)return null;
    List<String> lines = text.split("\n");
    if (lines.length > 0) {
      if (lines.last.isEmpty) lines.removeLast();
    }
    return lines[lineNumber] + ((lineNumber >= lines.length - 1) ? "\n" : "\n");
  }

  static TextSelection selectLine({required String text, required int lineNumber}) {
    List<String> lines = text.split("\n");
    if (lines.length > 0) {
      if (lines.last.isEmpty) lines.removeLast();
    }

    String alreadySearched = "";
    int startIndex = -1;
    String? line;
    for (line in lines) {

      int index = lines.indexOf(line);
      if (index != lines.length) line += "\n";
      if (index == lineNumber) {
        startIndex = alreadySearched.length;
        break;
      } else {
        alreadySearched += line;
      }
    }

    if (startIndex == -1 || line == null) {
      throw "Error selectLine";
    }

    int endIndex = startIndex + line.length;
    if (line.isNotEmpty &&
        line.substring(line.length - 1, line.length) == "\n") {
      endIndex -= 1;
    }

    if (endIndex - startIndex == 0) {
      return TextSelection.collapsed(offset: startIndex);
    } else
      return TextSelection(extentOffset: endIndex, baseOffset: startIndex);
  }

  static TextSelection selectNextLine(String text, int currentLine) {
    if (currentLine + 1 < getTotalLineNumber(text))
      return selectLine(text: text, lineNumber: currentLine + 1);
    else
      return selectLine(text: text, lineNumber: currentLine );  }
}
