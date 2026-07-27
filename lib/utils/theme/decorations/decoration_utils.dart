import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/decorations/border_radius_utils.dart';
import 'package:constructo/utils/theme/decorations/border_utils.dart';
import 'package:flutter/material.dart';

DecorationImage decorationImageCustom(String imgFullPath, {BoxFit? boxfit}) {
  return DecorationImage(
    image: AssetImage(imgFullPath),
    fit: boxfit ?? BoxFit.fill,
  );
}

List<BoxShadow> boxShadowDefault() {
  return [
    const BoxShadow(
      color: Color(0x40000000),
      blurRadius: 2,
      spreadRadius: 0,
      offset: Offset.zero,
    ),
  ];
}

List<BoxShadow> boxShadowCard() {
  return [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 5,
      offset: const Offset(0, 3),
      spreadRadius: 0,
    ),
  ];
}

LinearGradient linerGredientHomeScreen() {
  return LinearGradient(
    colors: [AppColors.scafoldBg, AppColors.white],
    begin: AlignmentGeometry.topCenter,
    end: AlignmentGeometry.bottomCenter,
  );
}

LinearGradient linerGredientFDFDFFcolorF0F5FF() {
  return LinearGradient(
    colors: [AppColors.colorFDFDFF, AppColors.colorF0F5FF],
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
  );
}

Gradient gradientCustom() {
  return const LinearGradient(
    colors: [Color(0xFFFFAE00), Color(0xFFFF6A00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

Decoration blueDecoration() {
  return BoxDecoration(
    border: borderCustomColorWhite20(),
    borderRadius: borderRadius2(),
    color: AppColors.primary.withValues(alpha: 0.5),
  );
}

Decoration redDecoration() {
  return BoxDecoration(
    border: borderCustomColorWhite20(),
    borderRadius: borderRadius2(),
    color: AppColors.colorE02E32RedTab,
  );
}
