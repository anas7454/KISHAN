// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemePref {
//   static const String _theme = "theme";

//   /// Save ThemeMode
//   static Future<void> setTheme(ThemeMode theme) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_theme, theme.index); // 0 = system, 1 = light, 2 = dark
//   }

//   /// Load ThemeMode
//   static Future<ThemeMode> getTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final index = prefs.getInt(_theme) ?? 2; // default  dark
//     return ThemeMode.values[index];
//   }
// }
