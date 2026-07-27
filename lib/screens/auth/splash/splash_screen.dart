import 'package:constructo/screens/auth/splash/splash_controller.dart';
import 'package:constructo/utils/images/image_utility/background_images_utility.dart';
import 'package:constructo/utils/images/image_utility/image_utility.dart';
import 'package:constructo/utils/theme/decorations/decoration_utils.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 30.rh),

        decoration: BoxDecoration(
          image: decorationImageCustom(BackgroundImagesUtility.onboardingBG),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImageUtility.logoOnboarding,
                width: 158.rw,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
