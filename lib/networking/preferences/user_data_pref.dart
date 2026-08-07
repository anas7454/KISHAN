import 'dart:convert';
import 'package:constructo_worker/networking/user/models/user_model.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataPref {
  static const String _userDataKey = "user_data";

  /// Save token
  static Future<void> setUserData(Map data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(data));
  }

  /// Load token
  static Future<UserModel> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userDataString = prefs.getString(_userDataKey) ?? "";
      final Map userData = jsonDecode(userDataString);
      return UserModel.fromMap(userData);
    } catch (e) {
      return UserModel();
    }
  }

  /// Remove token (logout ke liye)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }

  // /// Check if token exists
  // static Future<bool> hasToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(_userDataKey);
  //   return token != null && token.isNotEmpty;
  // }

  static bool isJwtExpired(String token) {
    printDebugCustom("isJwtExpired token -->$token");
    try {
      if (token.isEmpty) {
        return true;
      }
      final parts = token.split('.');
      if (parts.length != 3) {
        return false; // invalid token - mtlb jwt nhi h to aage jane de
      }

      final payload = base64Url.normalize(parts[1]);
      final decoded = json.decode(utf8.decode(base64Url.decode(payload)));

      if (decoded['exp'] == null) return true;

      final expiry = DateTime.fromMillisecondsSinceEpoch(decoded['exp'] * 1000);
      printDebugCustom("Token expires at: $expiry"); // Print expiry datetime
      printDebugCustom("Token =>$token"); // Print expiry datetime
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return true; // in case of any error, treat as expired
    }
  }
}
