import 'package:constructo/screens/auth/login/login_controller.dart';
import 'package:constructo/screens/auth/login/otp/login_otp_controller.dart';
import 'package:constructo/screens/auth/onboarding/onboarding_controller.dart';
import 'package:constructo/screens/auth/splash/splash_controller.dart';
import 'package:constructo/screens/auth/social_login/apple_login/apple_login_controller.dart';
import 'package:constructo/screens/auth/social_login/google_login/google_login_controller.dart';
import 'package:constructo/screens/auth/social_login/social_login_controller.dart';
import 'package:get/get.dart';

class SplashScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}

class OnboardingScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}

// login screen
class LoginScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => GoogleLoginController());
    Get.lazyPut(() => AppleLoginController());
    Get.lazyPut(() => SocialLoginController());
  }
}

class LoginOtpScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginOtpController());
  }
}
