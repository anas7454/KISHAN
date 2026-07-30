import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin Step1OnboardingWidget {
  static Widget mainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sizedboxHeight(58.rh),
          SizedBox(
            width: 362.rw,
            height: 297.rh,
            child: Image.asset(ImageUtility.group1, fit: BoxFit.contain),
          ),
          sizedboxHeight(12.rh),
          Column(
            children: [
              Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: AppTextStyles.ts16w600color000000().copyWith(
                  color: AppColors.primary,
                  fontSize: 18.rsp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              sizedboxHeight(2.rh),
              Text(
                "Constructo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lufga',
                  fontSize: 32.rsp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  letterSpacing: 0,
                  height: 1.0,
                ),
              ),
              sizedboxHeight(10.rh),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Build Your ",
                      style: AppTextStyles.ts24w600color000000().copyWith(
                        fontSize: 24.rsp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Career.\n",
                      style: AppTextStyles.ts24w600color000000().copyWith(
                        fontSize: 24.rsp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: "Earn Better",
                      style: AppTextStyles.ts24w600color000000().copyWith(
                        fontSize: 24.rsp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          sizedboxHeight(14.rh),
          SizedBox(
            width: 325.rw,
            child: Text(
              "Join thousands of skilled workers and get verified jobs near you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lufga',
                fontSize: 14.rsp,
                fontWeight: FontWeight.w400,
                color: AppColors.color4C4C4C,
                letterSpacing: 0,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
