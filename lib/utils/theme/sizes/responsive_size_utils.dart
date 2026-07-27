import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SizeExtensions on num {
  double get rw => AppSizes.sizeWidth(toDouble());
  double get rh => AppSizes.sizeHight(toDouble());
  double get rr => AppSizes.redius(toDouble());
  double get rsp => AppSizes.fontsize(toDouble());
}

double getHeight([double height = 1.0]) => Get.height * height;
double getWidth([double width = 1.0]) => Get.width * width;

Widget sizedboxHeight([double? height]) {
  return SizedBox(height: AppSizes.sizeHight(height ?? 15));
}

Widget sizedboxWidth([double? width]) {
  return SizedBox(width: AppSizes.sizeWidth(width ?? 12));
}
