import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/widgets/editor.dart';

enum InputShortcut { CUT, COPY, PASTE, SELECT_ALL }

typedef CursorMoveCallback = void Function(
    LogicalKeyboardKey key, bool wordModifier, bool lineModifier, bool shift);
typedef InputShortcutCallback = void Function(InputShortcut? shortcut);
typedef OnDeleteCallback = void Function(bool forward);

class KeyboardListener {
  KeyboardListener(this.onCursorMove, this.onShortcut, this.onDelete, this.decider);

  final CursorMoveCallback onCursorMove;
  final InputShortcutCallback onShortcut;
  final OnDeleteCallback onDelete;
  final keyDecider decider;
  static final Set<LogicalKeyboardKey> _moveKeys = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
  };

  static final Set<LogicalKeyboardKey> _shortcutKeys = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyC,
    LogicalKeyboardKey.keyV,
    LogicalKeyboardKey.keyX,
    LogicalKeyboardKey.delete,
    LogicalKeyboardKey.backspace,
  };

  static final Set<LogicalKeyboardKey> _nonModifierKeys = <LogicalKeyboardKey>{
    ..._shortcutKeys,
    ..._moveKeys,
  };

  static final Set<LogicalKeyboardKey> _modifierKeys = <LogicalKeyboardKey>{
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.alt,
  };

  static final Set<LogicalKeyboardKey> _macOsModifierKeys =
      <LogicalKeyboardKey>{
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.alt,
  };

  static final Set<LogicalKeyboardKey> _interestingKeys = <LogicalKeyboardKey>{
    ..._modifierKeys,
    ..._macOsModifierKeys,
    ..._nonModifierKeys,
  };

  static final Map<LogicalKeyboardKey, InputShortcut> _keyToShortcut = {
    LogicalKeyboardKey.keyX: InputShortcut.CUT,
    LogicalKeyboardKey.keyC: InputShortcut.COPY,
    LogicalKeyboardKey.keyV: InputShortcut.PASTE,
    LogicalKeyboardKey.keyA: InputShortcut.SELECT_ALL,
  };

  bool handleRawKeyEvent(RawKeyEvent event) {
    final isMacOS = event.data is RawKeyEventDataMacOs;

    if(event is RawKeyDownEvent&&(event.data.keyLabel=='Enter' || event.data.keyLabel=='Tab'  ) && !decider.call(event.logicalKey)  ) {
      /*onCursorMove(
          LogicalKeyboardKey.arrowDown,
          isMacOS ? event.isAltPressed : false,
          isMacOS ? event.isMetaPressed : false,
          false);*/

      return true;
    }
      if (kIsWeb) {
        // On web platform, we should ignore the key because it's processed already.
        return false;
      }

      if (event is! RawKeyDownEvent) {
        return false;
      }

      final keysPressed =
      LogicalKeyboardKey.collapseSynonyms(RawKeyboard.instance.keysPressed);
      final key = event.logicalKey;
      if (!_nonModifierKeys.contains(key) ||
          keysPressed
              .difference(isMacOS ? _macOsModifierKeys : _modifierKeys)
              .length >
              1 ||
          keysPressed.difference(_interestingKeys).isNotEmpty) {
        return false;
      }

      if (_moveKeys.contains(key)) {
        onCursorMove(
            key,
            isMacOS ? event.isAltPressed : event.isControlPressed,
            isMacOS ? event.isMetaPressed : event.isAltPressed,
            event.isShiftPressed);
      } else if (isMacOS
          ? event.isMetaPressed
          : event.isControlPressed && _shortcutKeys.contains(key)) {
        onShortcut(_keyToShortcut[key]);
      } else if (key == LogicalKeyboardKey.delete) {
        onDelete(true);
      } else if (key == LogicalKeyboardKey.backspace) {
        onDelete(false);
      }
      return false;
    }

}
