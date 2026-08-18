import 'dart:io';

import 'package:constructo_worker/screens/auth/social_login/social_login_controller.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoginWidgets {
  Widget continueWithDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderE6E6E6)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.rw),
          child: Text(
            'Or continue with',
            style: AppTextStyles.ts12w500color000000(),
          ),
        ),
        Expanded(child: Divider(color: AppColors.borderE6E6E6)),
      ],
    );
  }

  Widget socialLoginBtns(SocialLoginController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => Button(
              name: 'Google',
              imageAsset: CommonIconsUtility.google,
              btnType: EnumButtonType.outlineAuth,
              isLoading: controller.isGoogleLoading.value,
              onPressed: controller.googleLoginClick,
            ),
          ),
        ),
        if (Platform.isIOS) ...[
          sizedboxWidth(15),
          Expanded(
            child: Obx(
              () => Button(
                name: 'Apple',
                imageAsset: CommonIconsUtility.apple,
                btnType: EnumButtonType.outlineAuth,
                isLoading: controller.isAppleLoading.value,
                onPressed: controller.appleLoginClick,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
