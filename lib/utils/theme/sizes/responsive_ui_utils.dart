mixin ResponsiveUiUtils {
  // static double mobileScreenMaxWidth = 430; // 370 se small hone par horzontal scroll aa jyega
  // static double mobileScreenWidth = 320.rw; // 370 se small hone par horzontal scroll aa jyega
  // static double btnMinmumWidth = 301; // btn ,textfield, dropdown btn
  // static double sidebarHideWidth = 601; // btn ,textfield, dropdown btn

  static double mobileScreenMaxWidth = 430;
}

// Condition
// final bool isTablet = getHeight() > 1100; // 1500 tak rhti h hm to 1100 pr he man rhe
// double getDragableSheetHeightForCarDetail(double screenHeight) {
//   if (screenHeight < 720) {
//     // very small phone
//     return 0.46;
//   } else if (screenHeight < 850) {
//     // small / normal phone
//     return 0.473; // 🔒 same as requested
//   } else if (screenHeight < 1020) {
//     // 990 -- sir ka testing
//     // big phone
//     return 0.485;
//   } else if (screenHeight < 1300) {
//     // small tablet
//     return 0.492;
//   } else if (screenHeight < 1600) {
//     // medium tablet
//     return 0.498; // 🔒 same as requested
//   } else {
//     // large tablet
//     return 0.51;
//   }
// }
// double getDragableSheetHeightForCarDetail(double screenHeight) {
//   const double baseScreenHeight = 810; // 🔒 FIXED
//   const double baseValue = 0.473; // 🔒 FIXED

//   // har 100px pe kitna change ho
//   const double changePer100px = 0.006;

//   final double diff = screenHeight - baseScreenHeight;

//   double value = baseValue + (diff / 150) * changePer100px;

//   // safety limits
//   return value.clamp(0.46, 0.51);
// }

double getDragableSheetHeightForCarDetail(double screenHeight) {
  const double baseScreenHeight = 810; // 🔒 fixed
  const double baseValue = 0.473; // 🔒 fixed

  // tuned so that 1500 → ~0.498
  const double changePer100px = 0.00362;

  final double diff = screenHeight - baseScreenHeight;

  double value = baseValue + (diff / 100) * changePer100px;

  return value.clamp(0.46, 0.51);
}
