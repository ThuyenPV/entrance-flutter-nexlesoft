import 'dart:ui';

import 'package:flutter/material.dart';

enum PasswordLevel {
  Weak,
  Fair,
  Good,
  Strong,
}

class PasswordLevelInfo {
  final PasswordLevel level;
  final Color color;

  PasswordLevelInfo(
    this.level,
    this.color,
  );
}

extension LevelExt on int {
  PasswordLevelInfo get getPasswordLevel {
    switch (this) {
      case 1:
        return PasswordLevelInfo(PasswordLevel.Weak, Colors.red);
      case 2:
        return PasswordLevelInfo(PasswordLevel.Fair, Colors.orange);
      case 3:
        return PasswordLevelInfo(PasswordLevel.Good, Colors.blue);
      case 4:
        return PasswordLevelInfo(PasswordLevel.Strong, Colors.green);
      default:
        return PasswordLevelInfo(PasswordLevel.Weak, const Color(0xff647FFF));
    }
  }
}
