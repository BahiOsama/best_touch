import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class CashedSharedPrefrances {
  static late SharedPreferences sharedPreferences;
  static Future cachInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCash(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getData({required String key}) {
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<bool> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
