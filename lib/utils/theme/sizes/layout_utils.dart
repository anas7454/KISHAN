import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';

BouncingScrollPhysics bouncingScrollPhysicsEffect() {
  return const BouncingScrollPhysics();
}

EdgeInsets listviewTopBottomPadding(int itrmlenght, int i) {
  return EdgeInsets.only(
    bottom: i + 1 == itrmlenght ? bottomstatusBarHeight : 0,
    top: i == 0 ? 15.rh : 0,
  );
}
