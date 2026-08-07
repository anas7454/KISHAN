import 'dart:async';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await Permission.notification.request();

      _redirect(1500);
    });
  }

  Future<void> _redirect(int timemillisecond) async {
    Timer(Duration(milliseconds: timemillisecond), () async {
      Future.delayed(const Duration(milliseconds: 300), () async {
        final UserController userController = Get.find();
        await userController.alreadyLoginCheck();
      });
    });
  }
}
