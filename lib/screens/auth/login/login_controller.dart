import 'package:constructo/networking/api/endpoints/auth_api_services.dart';
import 'package:constructo/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo/networking/extensions/api_helper.dart';
import 'package:constructo/routes/app_routes.dart';
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
    final Map<String, dynamic> rawData = {"mobile": phoneNumber};
    final response = await AuthApiServices.sendOtpLogin(rawData);
    isLoading.value = false;

    if (apiResponseSuccess(response)) {
      AppRoutes.loginOtpScreen(phoneNumber, apiPeramMap(response["data"]));
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
