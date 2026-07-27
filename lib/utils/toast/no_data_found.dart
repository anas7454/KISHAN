// ignore_for_file: prefer_const_constructors
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget circleProgressIndCustom({
  bool isTopPadding = false,
  double? topPadding,
  double? bottomPadding,
  Color? color,
  double? radius,
}) {
  return Center(
    child: Container(
      padding: EdgeInsets.only(
        top: topPadding ?? (isTopPadding ? getHeight(0.2) : 0),
        bottom: bottomPadding ?? 0,
      ),
      child: SizedBox(
        width: 24.rh,
        height: 24.rh,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
          backgroundColor: (color ?? AppColors.primary).withValues(alpha: 0.2),
          strokeWidth: radius ?? 2.5.r,
        ),
      ),
    ),
  );
}

Widget circleProgressIndCustomDialogBehv({
  bool isTopPadding = false,
  double? topPadding,
  Color? color,
  String text = "",
}) {
  return Scaffold(
    backgroundColor: text == "" ? Colors.black26 : Colors.black45,
    body: SizedBox(
      width: getWidth(),
      height: getHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text == ""
              ? circleProgressIndCustom(
                  isTopPadding: isTopPadding,
                  topPadding: topPadding,
                  color: color ?? Colors.white,
                )
              : Container(
                  width: getWidth(0.65),
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadiusDefault(8.r),
                    border: borderCustomDefault(),
                  ),
                  child: Column(
                    children: [
                      circleProgressIndCustom(
                        isTopPadding: isTopPadding,
                        topPadding: topPadding,
                        color: color ?? Colors.white,
                      ),
                      sizedboxHeight(15),
                      Text(
                        text,
                        style: AppTextStyles.ts14w600colorBlack().copyWith(
                          fontSize: 16.rsp,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    ),
  );
}

Widget noDataFound({
  String text = 'No Record found',
  double? topPadding,
  bool isTopPadding = false,
  Color? color,
}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(
        top: topPadding ?? (isTopPadding ? getHeight(0.2) : 0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.rh,
            height: 90.rh,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (color ?? AppColors.primary).withValues(alpha: .1),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 46.rsp,
              color: color ?? AppColors.primary,
            ),
          ),
          sizedboxHeight(14),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w600colorBlack().copyWith(
              fontSize: 16.sp,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

//  controller.isLoading.value ? circleProgressIndCustom(): controller.leaderboardList.isEmpty ? noDataFound(text: 'No Data')              :
