import 'package:constructo_worker/screens/auth/login/otp/login_otp_controller.dart';
import 'package:constructo_worker/utils/buttons/text_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoginOtpWidgets {
  Widget resendCodeTimer(LoginOtpController controller) {
    return Obx(() {
      if (controller.seconds.value > 0) {
        return Text(
          'Resend Code (${controller.seconds.value} sec)',
          style: AppTextStyles.ts11w400color808080(),
        );
      }

      return Align(
        alignment: Alignment.centerLeft,
        child: TextButtonCustom(
          onPressed: controller.isResending.value ? null : controller.resendOtp,
          btnName: controller.isResending.value ? 'Sending...' : 'Resend Code',
          textColor: controller.isResending.value
              ? AppColors.color474747
              : AppColors.color5B3BF7,
          textStyle: AppTextStyles.ts12w700colorFFFFFF(),
        ),
      );
    });
  }

  Widget resendCodeAction(LoginOtpController controller) {
    return Obx(() {
      final bool canResend =
          controller.seconds.value == 0 && !controller.isResending.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            "Didn't receive the code? ",
            style: AppTextStyles.ts12w500colorBlack50(),
          ),
          TextButtonCustom(
            onPressed: canResend ? controller.resendOtp : null,
            btnName: controller.isResending.value ? 'Sending...' : 'Send Again',
            textColor: canResend
                ? AppColors.color5B3BF7
                : AppColors.color474747,
            textStyle: AppTextStyles.ts11w700color000000(),
          ),
        ],
      );
    });
  }
}
