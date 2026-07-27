import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin Step3OnboardingWidget {
  static Widget mainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 322.rw,
            height: 349.rh,
            child: Image.asset(ImageUtility.onboarding3),
          ),
          // sizedboxHeight(10),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hire Verified &",
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
                      text: "Skilled Workers",
                      style: AppTextStyles.ts24w600color000000().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text(
            "Find trusted and experienced workers for every type or construction work. Book easily and get\nthe job done right.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w400color000000(),
          ),
        ],
      ),
    );
  }
}
