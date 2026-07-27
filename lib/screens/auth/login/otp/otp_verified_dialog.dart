import 'dart:async';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showOtpVerifiedDialog() {
  Timer? autoCloseTimer;

  final Future<void> dialog = showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) {
      autoCloseTimer ??= Timer(const Duration(seconds: 3), () {
        if (context.mounted) Navigator.pop(context);
      });

      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 32.rw),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.rr),
        ),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.rw, 16.rh, 18.rw, 22.rh),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButtonCustom(
                  onPressed: () => Navigator.pop(context),
                  buttonSize: 36.rh,
                  size: 22.rh,
                  iconData: Icons.close_rounded,
                  color: AppColors.color474747,
                ),
              ),
              Container(
                width: 118.rw,
                height: 118.rw,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffDDF4FF),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: 48.rw,
                    height: 48.rw,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 31.rsp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.rh),
              Text('OTP Verified', style: AppTextStyles.ts22w700color000000()),
              SizedBox(height: 8.rh),
              Text(
                'Your number is confirmed and you can now go ahead to the next step easily',
                textAlign: TextAlign.center,
                style: AppTextStyles.ts12w400color000000(),
              ),
              SizedBox(height: 22.rh),
              Button(
                name: 'Close',
                elevation: 0,
                height: 46.rh,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );

  return dialog.whenComplete(() => autoCloseTimer?.cancel());
}
