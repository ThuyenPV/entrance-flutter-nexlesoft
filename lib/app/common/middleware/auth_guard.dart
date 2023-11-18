import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../services/auth_service.dart';

class AuthGuard extends GetMiddleware {
  final AuthService authService = AuthService();

  @override
  RouteSettings? redirect(String? route) {
    if (authService.isLoggedIn.value) {
      return const RouteSettings(name: Routes.HOME);
    }
    return null;
  }
}
