import 'package:entrance_flutter/app/common/services/auth_service.dart';
import 'package:entrance_flutter/app/common/services/category_service.dart';
import 'package:entrance_flutter/app/common/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/nex_formfield.dart';

class SignInController extends GetxController {
  late GlobalKey<PasswordFormFieldState> passwordFormKey;
  late GlobalKey<EmailFormFieldState> emailFormKey;
  late AuthService authService;
  late CategoryService categoryService;

  @override
  void onInit() {
    emailFormKey = GlobalKey();
    passwordFormKey = GlobalKey();
    authService = Get.find<AuthService>();
    categoryService = Get.find<CategoryService>();
    // onGuardRedirect();
    super.onInit();
  }

  void onGuardRedirect() async {
    final isLoggedIn = await LocalStorage.onGetBool(key: SharedKey.isLoggedIn);
    if (isLoggedIn ?? false) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.SIGNIN);
    }
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
        final isLoggedIn = await authService.signIn(
          email: email ?? '',
          password: password ?? '',
        );
        if (isLoggedIn) {
          final isSelected = await categoryService.isSelectedCategory ?? false;
          if (isSelected) {
            Get.toNamed(Routes.HOME);
          } else {
            categoryService.onFetchCategories().then((value) {
              Get.toNamed(Routes.CATEGORY);
            });
          }
          Get.snackbar(
            'Login successful!',
            'Congratulations, you have successfully logged in',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
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
}
