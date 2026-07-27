import 'package:constructo_worker/screens/auth/onboarding/onboarding_controller.dart';
import 'package:constructo_worker/screens/auth/onboarding/onboarding_widgets.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step1_onboarding_widget.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step2_onboarding_widget.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step3_onboarding_widget.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/text_button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/background_images_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class OnboardingScreen extends StatelessWidget with OnboardingWidgets {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: getWidth(),
        decoration: BoxDecoration(
          image: decorationImageCustom(BackgroundImagesUtility.onboardingBG),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedboxHeight(statusBarHeight),
                sizedboxHeight(10),
                SizedBox(
                  width: 160.rw,
                  height: 35.rh,
                  child: Image.asset(ImageUtility.logoOnboarding),
                ),
                sizedboxHeight(10),
                const Expanded(child: PageViewOnboardingWidget()),
                footerWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
