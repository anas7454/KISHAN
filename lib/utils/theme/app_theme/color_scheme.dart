import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

ColorScheme lightColorScheme(BuildContext context) => ColorScheme(
  primary: AppColors.primary,
  secondary: AppColors.secondry,
  brightness: Brightness.light,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  surface: AppColors.cardBg,
  onSurface: AppColors.black,
  error: Colors.red,
  onError: Colors.white,
  tertiary: Colors.grey,
  onTertiary: AppColors.color1F1F1F,
);
