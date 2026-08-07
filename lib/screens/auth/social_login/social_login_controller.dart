import 'package:constructo_worker/networking/api/endpoints/auth_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/auth/social_login/apple_login/apple_login_controller.dart';
import 'package:constructo_worker/screens/auth/social_login/google_login/google_login_controller.dart';
import 'package:constructo_worker/screens/auth/social_login/social_login_model.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:get/get.dart';

class SocialLoginController extends GetxController {
  final GoogleLoginController googleLoginController =
      Get.find<GoogleLoginController>();
  final AppleLoginController appleLoginController =
      Get.find<AppleLoginController>();
  final RxBool isGoogleLoading = false.obs;
  final RxBool isAppleLoading = false.obs;

  Future<void> googleLoginClick() async {
    if (isGoogleLoading.value || isAppleLoading.value) return;
    final SocialLoginModel loginData = await googleLoginController.googleLogin(
      isGoogleLoading,
    );
    await _completeSocialLogin(loginData);
  }

  Future<void> appleLoginClick() async {
    if (isGoogleLoading.value || isAppleLoading.value) return;
    final SocialLoginModel loginData = await appleLoginController.appleLogin(
      isAppleLoading,
    );
    await _completeSocialLogin(loginData);
  }

  Future<void> _completeSocialLogin(SocialLoginModel loginData) async {
    if (!loginData.isValid) {
      if (loginData.error.isNotEmpty &&
          loginData.error != 'User cancelled login') {
        showToastError(loginData.error);
      }
      return;
    }

    final RxBool loading = loginData.signupBy == EnumSignupBy.google
        ? isGoogleLoading
        : isAppleLoading;
    loading.value = true;
    final Map response = loginData.signupBy == EnumSignupBy.google
        ? await AuthApiServices.google(<String, dynamic>{
            'idToken': loginData.idToken,
          })
        : await AuthApiServices.apple(<String, dynamic>{
            'identityToken': loginData.idToken,
          });
    loading.value = false;

    if (apiResponseSuccess(response)) {
      await Get.find<UserController>().setLoginData(
        apiPeramMap(response['data']),
      );
      showToastSuccess(response);
      AppRoutes.bottomNavBarScreen();
      return;
    }
    showdialogApiError(respMap: response);
  }
}
