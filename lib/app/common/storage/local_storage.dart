import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static void onSaveItem({
    required String key,
    required dynamic value,
  }) async {
    try {
      print('value >> ${value is String}');
      var prefs = await SharedPreferences.getInstance();
      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is List) {
        await prefs.setStringList(key, value as List<String>);
      } else {
        throw const FormatException('Invalid format type');
      }
    } catch (e) {
      throw ('Cannot save this $key');
    }
  }

  static Future<String?> onGetString({
    required String key,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> onGetItem({
    required String key,
    required dynamic type,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      if (type is String) {
        return prefs.getString(key);
      } else if (type is int) {
        return prefs.getInt(key);
      } else if (type is double) {
        return prefs.getDouble(key);
      } else if (type is bool) {
        return prefs.getBool(key);
      } else if (type is List) {
        return prefs.getStringList(key);
      } else {
        throw const FormatException('Invalid format type');
      }
    } catch (e) {
      throw ('Cannot get this $key');
    }
  }
}

class SharedKey {
  static const String accessToken = 'accessToken';
  static const String isLoggedIn = 'isLoggedIn';
  static const String isSelectedCategory = 'isSelectedCategory';
}
