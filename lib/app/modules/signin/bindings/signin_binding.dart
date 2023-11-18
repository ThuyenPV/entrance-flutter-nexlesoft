import 'package:entrance_flutter/app/common/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../common/services/category_service.dart';
import '../controllers/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<CategoryService>(() => CategoryService());
  }
}
