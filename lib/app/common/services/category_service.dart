import 'dart:convert';

import 'package:entrance_flutter/app/models/category.dart';
import 'package:entrance_flutter/app/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/local_storage.dart';

class CategoryService extends GetxController {
  RxBool isCategorySelected = false.obs;
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

  void onCompleteCategory() {
    LocalStorage.onSaveItem(key: SharedKey.isSelectedCategory, value: true);
    isCategorySelected.value = true;
  }
}
