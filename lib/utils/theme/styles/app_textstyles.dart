import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle _style(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: 'Lufga',
      fontSize: size.rsp,
      fontWeight: weight,
      color: color,
    );
  }

  // Component styles
  static TextStyle buttonTextStyle(BuildContext _) =>
      _style(14, FontWeight.w700, AppColors.black);

  static TextStyle textFiledHintStyle() =>
      _style(14, FontWeight.w500, AppColors.hintText);

  static TextStyle textFiledErrorTextStyle() =>
      _style(11, FontWeight.w400, Colors.red);

  static TextStyle textfieldInputHeaderStyle() => ts14w600colorBlack();

  static TextStyle textFiledLabelStyle() => ts14w500colorBlack();

  // 10px
  static TextStyle ts10w500colorBlack() =>
      _style(10, FontWeight.w500, AppColors.black);

  static TextStyle ts10w500color6B7080() =>
      _style(10, FontWeight.w500, AppColors.color6B7080);

  static TextStyle ts10w500colorFFFFFF() =>
      _style(10, FontWeight.w500, AppColors.white);

  static TextStyle ts10w500colorblackop2() =>
      _style(10, FontWeight.w500, AppColors.blackop2);

  static TextStyle ts10w600colorBlack() =>
      _style(10, FontWeight.w600, AppColors.black);

  // 11px
  static TextStyle ts11w400color808080() =>
      _style(11, FontWeight.w400, AppColors.color474747);

  static TextStyle ts11w500colorblack() =>
      _style(11, FontWeight.w500, AppColors.black);

  static TextStyle ts11w500color474747() =>
      _style(11, FontWeight.w500, AppColors.color474747);

  static TextStyle ts11w400colorblack() =>
      _style(11, FontWeight.w400, AppColors.black);

  static TextStyle ts11w400colorwhite() =>
      _style(11, FontWeight.w400, AppColors.white);

  static TextStyle ts11w600colorblack() =>
      _style(11, FontWeight.w600, AppColors.black);

  static TextStyle ts11w400colorPrimary() =>
      _style(11, FontWeight.w400, AppColors.primary);

  static TextStyle ts11w700color000000() =>
      _style(11, FontWeight.w700, AppColors.black);

  // 12px
  static TextStyle ts12w400color000000() =>
      _style(12, FontWeight.w400, AppColors.black);

  static TextStyle ts12w400color474747() =>
      _style(12, FontWeight.w400, AppColors.color474747);
  static TextStyle ts10w400color7D7D7D() =>
      _style(10, FontWeight.w400, AppColors.color7D7D7D);

  static TextStyle ts10w700colorblack() =>
      _style(10, FontWeight.w700, AppColors.black);

  static TextStyle ts9w400color5C5C5C() =>
      _style(9, FontWeight.w400, AppColors.color5C5C5C);

  static TextStyle ts12w400colorWhite() =>
      _style(12, FontWeight.w400, AppColors.white);

  static TextStyle ts12w500color000000() =>
      _style(12, FontWeight.w500, AppColors.black);

  static TextStyle ts12w500colorBlack() =>
      _style(12, FontWeight.w500, AppColors.black);

  static TextStyle ts12w500colorBlack50() =>
      _style(12, FontWeight.w400, AppColors.black.withValues(alpha: 0.5));
  static TextStyle ts8w500colorBlack() =>
      _style(8, FontWeight.w500, AppColors.black);

  static TextStyle ts12w500color808080() =>
      _style(12, FontWeight.w500, AppColors.color808080);
  static TextStyle ts12w500color808080op50() =>
      _style(12, FontWeight.w500, AppColors.color808080op50);

  static TextStyle ts12w600color000000() =>
      _style(12, FontWeight.w600, AppColors.black);

  static TextStyle ts12w600colorFFFFFF() =>
      _style(12, FontWeight.w600, AppColors.white);

  static TextStyle ts12w700colorFFFFFF() =>
      _style(12, FontWeight.w700, AppColors.white);

  static TextStyle ts12_8w400colorBFBFBF() =>
      _style(12.8, FontWeight.w400, AppColors.colorBFBFBF);

  // 14px
  static TextStyle ts14w400color000000() =>
      _style(14, FontWeight.w400, AppColors.black);

  static TextStyle ts14w400color1C1C1C() =>
      _style(14, FontWeight.w400, AppColors.color1C1C1C);

  static TextStyle ts14w500color7D7D7D() =>
      _style(14, FontWeight.w500, AppColors.color7D7D7D);

  static TextStyle ts14w500colorBlack() =>
      _style(14, FontWeight.w500, AppColors.black);

  static TextStyle ts14w600colorBlack() =>
      _style(14, FontWeight.w600, AppColors.black);

  static TextStyle ts14w700colorBlack() =>
      _style(14, FontWeight.w700, AppColors.black);

  // Headings
  static TextStyle ts16w600color000000() =>
      _style(16, FontWeight.w600, AppColors.black);

  static TextStyle ts18w700color000000() =>
      _style(18, FontWeight.w700, AppColors.black);

  static TextStyle ts16w600colorFFFFFF() =>
      _style(16, FontWeight.w600, AppColors.white);

  static TextStyle ts20w600color000000ClashDisplay() =>
      _style(20, FontWeight.w600, AppColors.black);

  static TextStyle ts20w700color000000() =>
      _style(20, FontWeight.w700, AppColors.black);

  static TextStyle ts22w700color000000() =>
      _style(22, FontWeight.w700, AppColors.black);

  static TextStyle ts23w600color000000ClashDisplay() =>
      _style(23, FontWeight.w600, AppColors.black);

  static TextStyle ts24w600color000000() =>
      _style(24, FontWeight.w600, AppColors.black);

  static TextStyle ts25w600color000000ClashDisplay() =>
      _style(25, FontWeight.w600, AppColors.black);

  static TextStyle ts25w700color000000() =>
      _style(25, FontWeight.w700, AppColors.black);

  static TextStyle ts28w600color000000() =>
      _style(28, FontWeight.w600, AppColors.black);
}
