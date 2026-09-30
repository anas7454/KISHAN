import 'dart:async';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRouteName.bottomNavBarScreen);
    });
  }
}
