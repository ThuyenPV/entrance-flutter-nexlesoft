import 'package:flutter/material.dart';

class PrivaryAndTerm extends StatelessWidget {
  const PrivaryAndTerm({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text:
            'By clicking Sign Up, you are indicating that you have read and agree to the ',
        style: TextStyle(
          color: Colors.white70,
        ),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: Color(0xff6C66FF),
            ),
          ),
          TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: Color(0xff6C66FF),
            ),
          ),
        ],
      ),
    );
  }
}
