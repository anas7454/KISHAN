import 'package:constructo/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// black icons
SystemUiOverlayStyle whiteThemeSystemUI({
  bool isTransparentNavigationBarColor = true,
}) {
  // dark text and icon
  return SystemUiOverlayStyle(
    // Status Bar
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light, // iOS: dark icons
    statusBarIconBrightness: Brightness.dark, // Android: dark icons
    // Navigation Bar
    systemNavigationBarColor: isTransparentNavigationBarColor
        ? Colors.transparent
        : Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark, // Android dark icons
    systemNavigationBarDividerColor: isTransparentNavigationBarColor
        ? Colors.transparent
        : Colors.white,
    systemNavigationBarContrastEnforced: false,
  );
}

// white icons

SystemUiOverlayStyle darkThemeSystemUI({
  bool isTransparentNavigationBarColor = true,
}) {
  return SystemUiOverlayStyle(
    // Status Bar
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,

    // Navigation Bar
    systemNavigationBarColor: isTransparentNavigationBarColor
        ? Colors.transparent
        : AppColors.primary, // ✅ FIX
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: isTransparentNavigationBarColor
        ? Colors.transparent
        : AppColors.primary,

    systemNavigationBarContrastEnforced: false, // ✅ IMPORTANT (Android 10+)
  );
}

// white icons
// SystemUiOverlayStyle darkThemeSystemUI({
//   bool isTransparentNavigationBarColor = true,
// }) {
//   return SystemUiOverlayStyle(
//     // Status Bar
//     // statusBarColor: Colors.transparent,
//     statusBarColor: AppColors.primary,
//     statusBarBrightness: Brightness.dark,
//     statusBarIconBrightness: Brightness.light,

//     // Navigation Bar
//     systemNavigationBarColor: AppColors.primary, // ✅ FIX
//     systemNavigationBarIconBrightness: Brightness.light,
//     systemNavigationBarDividerColor: AppColors.primary,

//     systemNavigationBarContrastEnforced: false, // ✅ IMPORTANT (Android 10+)
//   );
// }

// 3 icon bg change wrapper
Widget bottomNavColorChange({required Widget child}) {
  return ColoredBox(
    color: AppColors.primary,
    child: SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: child,
    ),
  );
}
