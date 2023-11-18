import 'package:entrance_flutter/app/core/helpers/password_level.dart';
import 'package:entrance_flutter/app/core/mixin/password_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailFormField extends StatefulWidget {
  const EmailFormField({super.key});

  @override
  EmailFormFieldState createState() => EmailFormFieldState();
}

class EmailFormFieldState extends State<EmailFormField> {
  late FocusNode _emailFocus;
  late ValueNotifier<bool> isEmailFocused;
  late TextEditingController emailController;
  late GlobalKey<FormState> _emailFormKey;

  @override
  void initState() {
    _emailFocus = FocusNode();
    _emailFocus.addListener(_onFocusChange);
    _emailFormKey = GlobalKey<FormState>();

    emailController = TextEditingController();
    isEmailFocused = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _emailFocus.removeListener(_onFocusChange);
    emailController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    isEmailFocused.value = _emailFocus.hasFocus;
  }

  bool onValidate() {
    return _emailFormKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _emailFormKey,
          child: TextFormField(
            controller: emailController,
            focusNode: _emailFocus,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              labelText: 'Your email',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'The email is required';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                  .hasMatch(value)) {
                return 'The email is not valid';
              }
              return null;
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: isEmailFocused,
          builder: (_, bool isFocused, __) {
            return Container(
              height: 1.5,
              width: 1.sh,
              color: isFocused ? Color(0xff647FFF) : Colors.grey,
            );
          },
        ),
      ],
    );
  }
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField>
    with PasswordMixin {
  late TextEditingController passwordController;
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  late FocusNode _passwordFocus;
  late ValueNotifier<bool> _isPasswordFocused;

  String _passwordLevel = 'Weak';
  int _passwordStrength = 0;
  bool _obscurePassword = true;

  @override
  void initState() {
    _passwordFocus = FocusNode();
    passwordController = TextEditingController();
    _isPasswordFocused = ValueNotifier(false);
    _passwordFocus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    _passwordFocus.removeListener(_onFocusChange);
    _passwordFocus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _isPasswordFocused.value = _passwordFocus.hasFocus;
  }

  bool onValidate() {
    return _passwordFormKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _passwordFormKey,
          child: TextFormField(
            controller: passwordController,
            obscureText: _obscurePassword,
            focusNode: _passwordFocus,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              labelText: 'Your password',
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: (password) {
              setState(() {
                _passwordLevel = determinePasswordStrength(password).level;
                _passwordStrength =
                    determinePasswordStrength(password).strength;
              });
            },
            validator: (password) {
              if (password == null || password.isEmpty) {
                return 'The password is required';
              } else if (password.length < 6 || password.length > 18) {
                return 'Too short';
              }
              return null;
            },
          ),
        ),
        Stack(
          fit: StackFit.loose,
          children: [
            Container(
              height: 1.5,
              width: 1.sh,
              color: Colors.grey,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder(
                valueListenable: _isPasswordFocused,
                builder: (_, isFocused, __) {
                  return Container(
                    height: 1.5,
                    width: _passwordStrength * 1.sw / 4,
                    color: isFocused
                        ? _passwordStrength.getPasswordLevel.color
                        : Colors.grey,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _passwordLevel,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
