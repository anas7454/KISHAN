import 'dart:io';

import 'package:constructo/screens/auth/social_login/social_login_controller.dart';
import 'package:constructo/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo/utils/buttons/text_button_custom.dart';
import 'package:constructo/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
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

  Widget signupText({VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.ts14w500colorBlack(),
        ),
        TextButtonCustom(
          onPressed: onTap ?? () {},
          btnName: 'Sign Up',
          textColor: AppColors.color5B3BF7,
          isUnderline: true,
        ),
      ],
    );
  }
}
