import 'package:constructo/screens/auth/login/otp/login_otp_controller.dart';
import 'package:constructo/screens/auth/login/otp/login_otp_widgets.dart';
import 'package:constructo/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo/utils/const_helper_methods.dart';
import 'package:constructo/utils/scafolds/auth_scaffold.dart';
import 'package:constructo/utils/textfield/common_otp_pinput.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOtpScreen extends StatelessWidget with LoginOtpWidgets {
  LoginOtpScreen({super.key});

  final LoginOtpController controller = Get.find<LoginOtpController>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
            'Enter the code sent to ${maskedPhoneNumber(controller.phoneNumber.value)}',
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w400color1C1C1C(),
          ),
          SizedBox(height: 30.rh),

          optTextFieldPinput(
            inputHeaderName: "Enter Code",
            otpEnterString: controller.otpController,
            errorhightAdded: false,
          ),
          SizedBox(height: 10.rh),
          resendCodeTimer(controller),
          SizedBox(height: 22.rh),
          Obx(
            () => Button(
              name: 'Continue',
              isLoading: controller.isLoading.value,
              elevation: 0,
              height: 46.rh,
              onPressed: controller.verifyOtp,
            ),
          ),
          SizedBox(height: 20.rh),
          resendCodeAction(controller),
        ],
      ),
    );
  }
}
