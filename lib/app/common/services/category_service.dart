import 'dart:convert';

import 'package:entrance_flutter/app/models/category.dart';
import 'package:entrance_flutter/app/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../storage/local_storage.dart';

class CategoryService extends GetxController {
  RxList<Category> categories = RxList([]);

  Future<void> onFetchCategories() async {
    try {
      var accessToken = await getAccessToken();

      if (accessToken != null) {
        final response = await http.get(
          Uri.parse('http://streaming.nexlesoft.com:3001/categories'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body) as List<dynamic>;
          final categoryList =
              jsonResponse.map((e) => Category.fromJson(e)).toList();
          categories.value = categoryList;
        }
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<String?> getAccessToken() async {
    final userModel = await LocalStorage.onGetString(
      key: SharedKey.accessToken,
    );
    if (userModel != null) {
      final user = User.fromJson(jsonDecode(userModel));
      return user.accessToken;
    }
    return null;
  }

  Future<void> onCompleteCategory({required List<Category> categories}) async {
    try {
      LocalStorage.onSaveItem(key: SharedKey.isSelectedCategory, value: true);
      LocalStorage.onSaveItem(
        key: SharedKey.categorySelected,
        value: categories.map((e) => e.toJson().toString()).toList(),
      );
    } catch (e) {
      throw (e);
    }
  }

  Future<bool?> get isSelectedCategory async {
    return await LocalStorage.onGetBool(key: SharedKey.isSelectedCategory);
  }
}
