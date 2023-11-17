import 'package:entrance_flutter/app/core/helpers/password_level.dart';
import 'package:entrance_flutter/app/core/utils/password_utils.dart';
import 'package:entrance_flutter/app/widgets/nex_formfield.dart';
import 'package:flutter/material.dart';

mixin PasswordMixin on State<PasswordFormField> {
  PasswordResponse determinePasswordStrength(String input) {
    int strength = 0;

    if (input.isEmpty) {
      return PasswordResponse(
        level: '',
        stregth: 0,
      );
    } else if (input.length < 6) {
      return PasswordResponse(
        level: 'Too short',
        stregth: 1,
      );
    } else if (input.length > 18) {
      return PasswordResponse(
        level: 'Too long',
        stregth: 1,
      );
    }

    strength = PasswordUtils.calculatePasswordStrength(input);
    final level = strength.getPasswordLevel.level.name;

    return PasswordResponse(
      level: level,
      stregth: strength,
    );
  }
}

class PasswordResponse {
  final String level;
  final int stregth;

  PasswordResponse({
    required this.level,
    required this.stregth,
  });
}
