import 'dart:convert';

import 'package:constructo/networking/user/models/user_location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationPref {
  static const _key = 'user_location';

  static Future<void> save(UserLocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(location.toMap()));
  }

  static Future<UserLocationModel> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(_key);
      if (value == null || value.isEmpty) return UserLocationModel();
      return UserLocationModel.fromMap(jsonDecode(value));
    } catch (_) {
      return UserLocationModel();
    }
  }
}
