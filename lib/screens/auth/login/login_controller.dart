import 'package:constructo_worker/networking/api/endpoints/auth_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> sendOtp() async {
    if (!(formKey.currentState?.validate() ?? false) || isLoading.value) return;

    isLoading.value = true;
    String phoneNumber = phoneController.text.trim();
    final Map<String, dynamic> rawData = {"identifier": phoneNumber};
    final response = await AuthApiServices.sendOtpLogin(rawData);
    isLoading.value = false;

    if (apiResponseSuccess(response)) {
      AppRoutes.loginOtpScreen(phoneNumber);
    } else {
      showdialogApiError(respMap: response);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();

    super.onClose();
  }
}
