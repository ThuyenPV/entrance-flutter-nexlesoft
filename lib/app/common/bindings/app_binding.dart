import 'package:entrance_flutter/app/common/services/auth_service.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
  }
}
