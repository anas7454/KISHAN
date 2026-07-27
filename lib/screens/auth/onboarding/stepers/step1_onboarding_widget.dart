import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin Step1OnboardingWidget {
  static Widget mainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 322.rw,
            height: 265.rh,
            child: Image.asset(ImageUtility.onboarding1),
          ),
          // sizedboxHeight(10),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome\n",
                      style: AppTextStyles.ts16w600color000000().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: "Constructo",
                      style: AppTextStyles.ts28w600color000000(),
                    ),
                  ],
                ),
              ),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Everything ",
                      style: AppTextStyles.ts24w600color000000(),
                    ),
                    TextSpan(
                      text: "You Need ",
                      style: AppTextStyles.ts24w600color000000().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: "for Construction in One\nApp",
                      style: AppTextStyles.ts24w600color000000(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text(
            "Buy quality construction materials, hire verified workers, connect with trusted vendors, and manage your construction projects- all from one powerful mobile app.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w400color000000(),
          ),
        ],
      ),
    );
  }
}
