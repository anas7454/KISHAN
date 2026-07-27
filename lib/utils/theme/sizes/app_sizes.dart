import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSizes {
  // cta btn
  static double borderRadiusBtn = 100.r;
  // ----- BORDER RADIUS -----

  static double borderRadiusTextField = 10.r;
  static double borderRadiusCard = 10.r;
  static double borderRadius8 = redius(8);

  // ----- SPACING -----
  static double horzontalSpace15 = sizeWidth(12);
  static double vericalSpace15 = sizeHight(15);
  static double elevetionBtn = 0;
  static double borderThikness1Sp = 1.sp;

  // ----- FONT WEIGHT -----
  static FontWeight fw300 = FontWeight.w300;
  static FontWeight fw400 = FontWeight.w400;
  static FontWeight fw500 = FontWeight.w500;
  static FontWeight fw600 = FontWeight.w600;
  static FontWeight fw700 = FontWeight.w700;
  static FontWeight fw800 = FontWeight.w800;
  static FontWeight fw900 = FontWeight.w900;

  // ----- FONT SIZE -----
  // static double fontsize(double size) => size.sp;

  static double fontsize(double size) {
    final double screenWidth = ScreenUtil().screenWidth;

    // Base width (375 = iPhone X)
    const double baseWidth = 375;

    // Width difference
    double diff = screenWidth - baseWidth;

    // Tablet पर और ज्यादा boost (0.16 per 100px)
    const double changePer100px = 0.16;

    // Factor calculation
    double factor = 1 + (diff / 100) * changePer100px;

    // Mobile = 1.0 , Tablet = up to 1.65x (बहुत बढ़िया size)
    factor = factor.clamp(1.0, 1.65);

    return size * factor;
  }

  // ----- RADIUS -----
  static double redius(double radius) => radius.r;

  // ----- HEIGHT / WIDTH -----
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;

  // static double sizeHight(double height) => safeH(height);
  static double sizeHight(double h) {
    final double screenHeight = ScreenUtil().screenHeight;

    const double baseHeight = 810;
    const double baseFactor = 1.0;

    // पहले 0.065 था → अब 0.085 कर दिया (height तेजी से बढ़े)
    const double changePer100px = 0.085;

    final double diff = screenHeight - baseHeight;

    double factor = baseFactor + (diff / 100) * changePer100px;

    // Mobile = 1.0 , Tablet = अब up to 1.50x
    factor = factor.clamp(1.0, 1.50);

    return h * factor;
  }

  // static double sizeWidth(double width) => safeW(width);
  static double sizeWidth(double w) {
    final double screenWidth = ScreenUtil().screenWidth;

    const double baseWidth = 375;
    const double baseFactor = 1.0;

    // पहले 0.102 था → अब और boost = 0.130
    const double changePer100px = 0.130;

    final double diff = screenWidth - baseWidth;

    double factor = baseFactor + (diff / 100) * changePer100px;

    // Mobile = 1.0, Tablet = up to 1.70x (20% more boost)
    factor = factor.clamp(1.0, 1.70);

    return w * factor;
  }

  // static double sizeH15 = safeH(15);

  // ----- SAFE HEIGHT / WIDTH -----

  // static double safeH(double h) => max(h.h, h);
  // static double safeW(double w) => max(w.w, w);
}

double statusBarHeight = Get.mediaQuery.padding.top;
double bottomstatusBarHeight = Get.mediaQuery.padding.bottom;

double horzontalSpace = 12.rw;

EdgeInsets appBarPaddingTopConst = EdgeInsets.symmetric(
  horizontal: AppSizes.sizeWidth(15),
).copyWith(top: statusBarHeight + AppSizes.sizeHight(5));
