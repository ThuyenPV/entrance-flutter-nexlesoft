import 'package:entrance_flutter/app/common/services/auth_service.dart';
import 'package:entrance_flutter/app/common/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/nex_formfield.dart';

class SignInController extends GetxController {
  late GlobalKey<PasswordFormFieldState> passwordFormKey;
  late GlobalKey<EmailFormFieldState> emailFormKey;
  late AuthService authController;
  late CategoryService networkController;

  @override
  void onInit() {
    emailFormKey = GlobalKey();
    passwordFormKey = GlobalKey();
    authController = Get.find<AuthService>();
    networkController = Get.find<CategoryService>();
    super.onInit();
  }

  void onSignin() async {
    final passwordState = passwordFormKey.currentState;
    final emailState = emailFormKey.currentState;
    final isValidPassword = passwordState?.onValidate() ?? false;
    final isValidEmail = emailState?.onValidate() ?? false;
    final password = passwordState?.passwordController.text;
    final email = emailState?.emailController.text;
    if (isValidPassword && isValidEmail) {
      try {
        final isLoggedIn = await authController.signIn(
          email: email ?? '',
          password: password ?? '',
        );
        if (isLoggedIn) {
          networkController.onFetchCategories().then((value) {
            Get.snackbar(
              'Login successful!',
              'Congratulations, you have successfully logged in',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.toNamed(Routes.CATEGORY);
          });
        } else {
          Get.snackbar(
            'Something went wrong!',
            'Unauthorized',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Something went wrong!',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
