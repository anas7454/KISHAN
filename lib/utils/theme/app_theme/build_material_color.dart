// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:flutter/material.dart';

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  var swatch = <int, Color>{};
  final double r = color.r, g = color.g, b = color.b;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      (r + ((ds < 0 ? r : (255 - r)) * ds).round()).toInt(),
      (g + ((ds < 0 ? g : (255 - g)) * ds).round()).toInt(),
      (b + ((ds < 0 ? b : (255 - b)) * ds).round()).toInt(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
