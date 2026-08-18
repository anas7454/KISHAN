import 'package:constructo_worker/screens/auth/login/login_controller.dart';
import 'package:constructo_worker/screens/auth/login/login_widgets.dart';
import 'package:constructo_worker/screens/auth/social_login/social_login_controller.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/scafolds/auth_scaffold.dart';
import 'package:constructo_worker/utils/textfield/phone_num_textfield.dart';
import 'package:constructo_worker/utils/textfield/textfield_widgets.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget with LoginWidgets {
  LoginScreen({super.key});

  final LoginController controller = Get.find<LoginController>();
  final SocialLoginController socialLoginController =
      Get.find<SocialLoginController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AuthScaffold(
        formKey: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: AppTextStyles.ts25w700color000000(),
            ),
            SizedBox(height: 5.rh),
            Text(
              'Enter your phone number to continue',
              textAlign: TextAlign.center,
              style: AppTextStyles.ts14w400color1C1C1C(),
            ),
            SizedBox(height: 30.rh),
            CommonTextFields.phoneTextField(
              phoneController: controller.phoneController,

              onFieldSubmitted: (_) => controller.sendOtp(),
            ),
            SizedBox(height: 19.rh),
            Obx(
              () => Button(
                name: 'Get OTP',
                isLoading: controller.isLoading.value,

                onPressed: controller.sendOtp,
              ),
            ),
            SizedBox(height: 25.rh),
            continueWithDivider(),
            SizedBox(height: 20.rh),
            Button(
              name: 'Continue with Email',
              imageAsset: CommonIconsUtility.email,
              btnType: EnumButtonType.outlineAuth,
              onPressed: () {},
            ),
            SizedBox(height: 15.rh),
            socialLoginBtns(socialLoginController),
          ],
        ),
      ),
    );
  }
}
