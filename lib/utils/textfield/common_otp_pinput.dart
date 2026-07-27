import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

Widget optTextFieldPinput({
  required TextEditingController otpEnterString,

  String? inputHeaderName,
  bool errorhightAdded = true,
  bool isCenterPin = false,
}) {
  double pinHight = 55.h;

  int pinLength = 4;
  final defaultPinTheme = PinTheme(
    width: 55.w,
    height: pinHight,
    margin: EdgeInsets.only(right: 10.rw),
    textStyle: AppTextStyles.textFiledLabelStyle(),
    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    decoration: BoxDecoration(
      // color: ColorUtility.colorTextFieldFillColor,
      borderRadius: borderRadiusDefault(AppSizes.borderRadiusTextField),
      border: borderCustomDefault(),
    ),
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (inputHeaderName != null)
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            inputHeaderName,
            style: AppTextStyles.textfieldInputHeaderStyle(),
          ),
        ),

      SizedBox(
        // color: Colors.amber,
        height: errorhightAdded ? pinHight + 30.h : null,
        child: Pinput(
          controller: otpEnterString,
          length: pinLength,
          animationDuration: const Duration(milliseconds: 8),

          mainAxisAlignment: isCenterPin
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          errorTextStyle: AppTextStyles.textFiledErrorTextStyle(),
          defaultPinTheme: defaultPinTheme,
          validator: (String? value) {
            if (value == null ||
                value.trim().isEmpty ||
                value.trim().length != pinLength) {
              return "Please enter an valid OTP";
            }

            if (value.trim().length != pinLength) {
              return "Please Enter $pinLength length pin";
            }

            return null;
          },
          // onSubmitted: (String pin) {
          //   pinputcontroller.text = pin;
          // },
          // onCompleted: (pin) {
          //   debugPrint('onCompleted: $pin');
          // },
          onChanged: (value) {
            debugPrint('onChanged: $value');
            // otpEnterString.value = value;
          },
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              borderRadius: borderRadiusDefault(AppSizes.borderRadiusTextField),
              border: borderCustomDefault(color: AppColors.primary),
            ),
          ),

          errorPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration?.copyWith(
              border: Border.all(color: Colors.red, width: 1.sp),
            ),
          ),
        ),
      ),
    ],
  );
}


          // optTextFieldPinput(
          //   otpEnterString: controller.otpController,
          //   errorhightAdded: false,
          // ),
