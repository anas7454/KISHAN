import 'dart:async';

import 'package:constructo_worker/networking/api/endpoints/auth_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/routes/arguments.dart';
import 'package:constructo_worker/screens/auth/login/otp/otp_verified_dialog.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isResending = false.obs;
  final RxInt seconds = 30.obs;

  final RxString phoneNumber = "".obs;
  RxMap<String, dynamic> otpData = <String, dynamic>{}.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final Map? arguments = Get.arguments;
    if (arguments != null) {
      phoneNumber.value = apiPeramString(arguments[Arguments.phoneNumber]);
      otpData.value = Map<String, dynamic>.from(
        apiPeramMap(arguments[Arguments.data]),
      );
      _startTimer();
    }
  }

  Future<void> verifyOtp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(formKey.currentState?.validate() ?? false) || isLoading.value) return;

    isLoading.value = true;
    final Map<String, dynamic> rawData = {
      // "name": "",
      "code": apiSendTextController(otpController),
    };
    // final response = await AuthApiServices.verifyOtpLogin(
    //   rawData,
    //   apiPeramString(otpData["tokenId"]),
    // );
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    // if (apiResponseSuccess(response)) {
    //   await Get.find<UserController>().setLoginData(
    //     apiPeramMap(response['data']),
    //   );
      await showOtpVerifiedDialog();
      AppRoutes.workerRegistrationScreen();
      return;
    // }

    // showdialogApiError(respMap: response);
  }

  Future<void> resendOtp() async {
    if (seconds.value > 0 || isResending.value) return;

    isResending.value = true;
    final Map<String, dynamic> rawData = {"mobile": phoneNumber.value};
    // final response = await AuthApiServices.sendOtpLogin(rawData);
    await Future.delayed(const Duration(seconds: 1));
    isResending.value = false;

    // if (apiResponseSuccess(response)) {
    //   otpData.value = Map<String, dynamic>.from(apiPeramMap(response["data"]));
      showToastSuccess('OTP sent again');
      _startTimer();
    // } else {
    //   showdialogApiError(respMap: response);
    // }
  }

  void _startTimer() {
    _timer?.cancel();
    seconds.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
