import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin Step2OnboardingWidget {
  static Widget mainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 322.rw,
            height: 344.rh,
            child: Image.asset(ImageUtility.onboarding2),
          ),
          // sizedboxHeight(10),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Buy Quality",
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
                      text: "Construction Materials",
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
            "Choose from a wide range of premium\nmaterials from trusted brands. Best prices,\nassured quality and on-time delivery at your\nsite.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w400color000000(),
          ),
        ],
      ),
    );
  }
}
