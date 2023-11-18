import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../services/auth_service.dart';
import '../services/category_service.dart';

class AuthGuard extends GetMiddleware {
  final AuthService authService = Get.find<AuthService>();
  final CategoryService categoryService = Get.find<CategoryService>();

  @override
  RouteSettings? redirect(String? route) {
    if (!authService.isLoggedIn.value) {
      return const RouteSettings(name: Routes.HOME);
    }
    return null;
  }
}
