class PasswordUtils {
  static int calculatePasswordStrength(String input) {
    int strength = 0;

    if (_containsLowercase(input)) {
      strength++;
    }
    if (_containsUppercase(input)) {
      strength++;
    }
    if (_containsNumber(input)) {
      strength++;
    }
    if (_containsSpecialCharacter(input)) {
      strength++;
    }

    return strength;
  }

  static bool _containsLowercase(String input) {
    return RegExp(r'[a-z]').hasMatch(input);
  }

  static bool _containsUppercase(String input) {
    return RegExp(r'[A-Z]').hasMatch(input);
  }

  static bool _containsNumber(String input) {
    return RegExp(r'[0-9]').hasMatch(input);
  }

  static bool _containsSpecialCharacter(String input) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input);
  }

  static bool containsEmailAddress(String input) {
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(input);
  }
}
