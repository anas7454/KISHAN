import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';

Widget dividerCustom({
  Color? color,
  double? width,
  double? horzontalMargin,
  double? verticalMargin,
  double? height,
  EdgeInsets? margin,
}) {
  return Container(
    margin:
        margin ??
        EdgeInsets.symmetric(
          horizontal: horzontalMargin ?? 0,
          vertical: verticalMargin ?? 0,
        ),
    color: color ?? AppColors.border,
    width: width ?? getWidth(),
    height: height ?? AppSizes.borderThikness1Sp,
  );
}

Widget dividerVerical({Color? color, double? width, double? height}) {
  return Container(
    color: color ?? AppColors.border,
    width: width ?? 1.rw,
    height: height ?? 20.rh,
  );
}

Widget dividerVericalcolorF3F3F3({
  Color? color,
  double? width,
  double? height,
}) {
  return Container(
    color: color ?? AppColors.colorF3F3F3,
    width: width ?? 1.rw,
    height: height ?? 20.rh,
  );
}

Widget dividerEEEEEE({double? verticalMargin}) {
  return dividerCustom(
    color: AppColors.colorEEEEEE,
    verticalMargin: verticalMargin ?? 0,
  );
}

Widget dividercolorF3F3F3({double? verticalMargin}) {
  return dividerCustom(
    color: AppColors.colorF3F3F3,
    verticalMargin: verticalMargin ?? 0,
  );
}

Widget dividerwhite20({double? verticalMargin}) {
  return dividerCustom(
    color: AppColors.borderWhite20,
    verticalMargin: verticalMargin ?? 0,
  );
}

Widget dividerE2E4E5({double? verticalMargin}) {
  return dividerCustom(
    color: AppColors.colorE2E4E5,
    verticalMargin: verticalMargin ?? 0,
  );
}
