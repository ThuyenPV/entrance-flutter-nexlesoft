import 'dart:convert';

import 'package:entrance_flutter/app/common/storage/local_storage.dart';
import 'package:entrance_flutter/app/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxController {
  RxBool isLoggedIn = false.obs;
  Rx<User?> userLoggedIn = Rx(null);

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://streaming.nexlesoft.com:3001/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final user = User.fromJson(jsonResponse);
        LocalStorage.onSaveItem(
          key: SharedKey.accessToken,
          value: response.body,
        );

        LocalStorage.onSaveItem(
          key: SharedKey.isLoggedIn,
          value: true,
        );

        ///
        isLoggedIn.value = true;
        userLoggedIn.value = user;
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<bool?> get getIsLoggedIn async {
    final isLoggedIn = await LocalStorage.onGetBool(key: SharedKey.isLoggedIn);
    return isLoggedIn;
  }
}
