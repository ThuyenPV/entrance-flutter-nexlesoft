import 'package:entrance_flutter/app/core/helpers/password_level.dart';
import 'package:entrance_flutter/app/core/mixin/password_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailFormField extends StatefulWidget {
  const EmailFormField({super.key});

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  late TextEditingController _emailController;
  late FocusNode _emailFocus;
  late ValueNotifier<bool> isEmailFocused;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
    isEmailFocused = ValueNotifier(false);
    _emailFocus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.removeListener(_onFocusChange);
    _emailFocus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    isEmailFocused.value = _emailFocus.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          focusNode: _emailFocus,
          controller: _emailController,
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
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  late TextEditingController _passwordController;

  late FocusNode _passwordFocus;
  late ValueNotifier<bool> _isPasswordFocused;

  String _passwordLevel = 'Weak';
  int _passwordStrength = 0;
  bool _obscurePassword = true;

  @override
  void initState() {
    _passwordFocus = FocusNode();
    _passwordController = TextEditingController();
    _isPasswordFocused = ValueNotifier(false);
    _passwordFocus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
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
            controller: _passwordController,
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
                _passwordStrength = determinePasswordStrength(password).stregth;
              });
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _isPasswordFocused,
          builder: (_, isFocused, __) {
            return Container(
              height: 1.5,
              width: 1.sh,
              color: isFocused
                  ? _passwordStrength.getPasswordLevel.color
                  : Colors.grey,
            );
          },
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
