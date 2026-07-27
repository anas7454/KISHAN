import 'package:constructo_worker/utils/common/focus_utils.dart';
import 'package:constructo_worker/utils/images/image_utility/background_images_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Widget child;

  const AuthScaffold({super.key, required this.formKey, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocusTwo();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BackgroundImagesUtility.loginBG),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: SafeArea(
            // bottom: false,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(horizontal: horzontalSpace),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 59.rh),
                    Center(
                      child: Image.asset(
                        ImageUtility.logoOnboarding,
                        width: 158.rw,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 66.rh),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
