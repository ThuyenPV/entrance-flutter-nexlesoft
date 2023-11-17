import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  RxString id = ''.obs;
  RxString email = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://streaming.nexlesoft.com:3001/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
      } else {
        throw Exception('Failed to sign up. ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('An error occurred. $error');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://streaming.nexlesoft.com:3001/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (error) {
      throw Exception('An error occurred. $error');
    }
  }
}
