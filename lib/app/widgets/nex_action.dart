import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.onTapSignup,
    required this.onTapContinue,
  });

  final VoidCallback onTapSignup;
  final VoidCallback onTapContinue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTapSignup,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        InkWell(
          onTap: onTapContinue,
          child: Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff6C66FF),
              ),
              borderRadius: BorderRadius.circular(48.h),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
