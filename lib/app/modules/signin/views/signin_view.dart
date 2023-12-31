import 'package:entrance_flutter/app/widgets/nex_checkbox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/nex_action.dart';
import '../../../widgets/nex_formfield.dart';
import '../../../widgets/nex_privacy_policy.dart';
import '../controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Assets.images.signupCover.image(fit: BoxFit.cover),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(bottom: 32, left: 16),
                  child: const Text(
                    'Let\'s get your started',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: const Color(0xff212121),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmailFormField(
                    key: controller.emailFormKey,
                  ),
                  PasswordFormField(
                    key: controller.passwordFormKey,
                  ),
                  const CheckboxField(),
                  const PrivaryAndTerm(),

                  /// Actions

                  GetBuilder(
                    initState: (state) {
                      Get.find<SignInController>().onValidatingFormField();
                    },
                    builder: (SignInController controller) {
                      return SignupButton(
                        isActive: controller.isValidFormField.value,
                        onTapSignup: () {
                          Get.to(Routes.SIGNUP);
                        },
                        onTapContinue: () {
                          controller.onSignin();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
