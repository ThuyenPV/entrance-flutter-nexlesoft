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
  late RxBool isValidFormField;

  @override
  void onInit() {
    emailFormKey = GlobalKey();
    passwordFormKey = GlobalKey();
    isValidFormField = RxBool(false);
    authService = Get.find<AuthService>();
    categoryService = Get.find<CategoryService>();
    onValidatingFormField();
    onGuardRedirect();
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

  void onValidatingFormField() {
    var isValidPassword = false;
    var isValidEmail = false;
    var passwordState = passwordFormKey.currentState;
    var emailState = emailFormKey.currentState;
    passwordState?.passwordController.addListener(() {
      if (passwordState.passwordController.text.isEmpty) {
        isValidFormField.value = false;
      } else {
        isValidPassword = passwordState.isValidPassword.value;
        isValidEmail = emailState?.isValidEmail.value ?? false;
        isValidFormField.value = isValidPassword && isValidEmail;
      }
      update();
    });

    emailState?.emailController.addListener(() {
      if (emailState.emailController.text.isEmpty) {
        isValidFormField.value = false;
      } else {
        isValidPassword = passwordState?.isValidPassword.value ?? false;
        isValidEmail = emailState.isValidEmail.value;
        isValidFormField.value = isValidPassword && isValidEmail;
      }
      update();
    });
  }

  void onSignin() async {
    final passwordState = passwordFormKey.currentState;
    final emailState = emailFormKey.currentState;
    final isValidPassword = passwordState?.isValidate() ?? false;
    final isValidEmail = emailState?.isValidate() ?? false;
    final password = passwordState?.passwordController.text;
    final email = emailState?.emailController.text;
    if (isValidPassword && isValidEmail) {
      try {
        final isLoggedIn = await authService.signIn(
          email: email ?? '',
          password: password ?? '',
        );
        if (isLoggedIn) {
          categoryService.onFetchCategories().then((value) {
            Get.toNamed(Routes.CATEGORY);
          });
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
