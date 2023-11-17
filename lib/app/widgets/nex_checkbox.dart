import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckboxField extends StatefulWidget {
  @override
  _CheckboxFieldState createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox.adaptive(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff6C66FF), width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: Color(0xff6C66FF),
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        const Gap(8),
        const Text(
          'I\'m over 16 years of age',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
