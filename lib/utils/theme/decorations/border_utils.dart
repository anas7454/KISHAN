import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/decorations/border_radius_utils.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

BoxBorder _border({
  required Color defaultColor,
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return Border.all(
    color: isTransperent ? Colors.transparent : color ?? defaultColor,
    width: isTransperent ? 0 : width ?? AppSizes.borderThikness1Sp,
  );
}

BoxBorder borderCustomDefault({
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return _border(
    defaultColor: AppColors.border,
    color: color,
    width: width,
    isTransperent: isTransperent,
  );
}

BoxBorder borderCustomcolorEDEDED({
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return _border(
    defaultColor: AppColors.colorEDEDED,
    color: color,
    width: width,
    isTransperent: isTransperent,
  );
}

BoxBorder borderCustomColorE6E6E6({
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return _border(
    defaultColor: AppColors.borderE6E6E6,
    color: color,
    width: width,
    isTransperent: isTransperent,
  );
}

BoxBorder borderCustomColorWhite20({
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return _border(
    defaultColor: AppColors.borderWhite20,
    color: color,
    width: width,
    isTransperent: isTransperent,
  );
}

BoxBorder borderCustomborderBlack05({
  Color? color,
  double? width,
  bool isTransperent = false,
}) {
  return _border(
    defaultColor: AppColors.borderBlack05,
    color: color,
    width: width,
    isTransperent: isTransperent,
  );
}

InputBorder borderInputDefault({
  Color? color,
  bool isUnderLineBorder = false,
  num? borderRadius,
}) {
  final BorderSide side = BorderSide(
    color: color ?? AppColors.borderTextfiled,
    width: AppSizes.borderThikness1Sp,
  );

  if (isUnderLineBorder) {
    return UnderlineInputBorder(borderSide: side);
  }

  return OutlineInputBorder(
    borderRadius: borderRadiusDefault(
      borderRadius ?? AppSizes.borderRadiusTextField,
    ),
    borderSide: side,
  );
}

RoundedRectangleBorder roundedRectangleBorderDefault() {
  return RoundedRectangleBorder(
    side: BorderSide(
      color: AppColors.border,
      width: AppSizes.borderThikness1Sp,
    ),
    borderRadius: borderRadiusDefault(),
  );
}
