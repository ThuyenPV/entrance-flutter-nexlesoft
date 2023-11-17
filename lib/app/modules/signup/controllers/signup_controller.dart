import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/nex_formfield.dart';

class SignupController extends GetxController {
  late GlobalKey<PasswordFormFieldState> passwordFormKey;

  final count = 0.obs;
  @override
  void onInit() {
    passwordFormKey = GlobalKey();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
