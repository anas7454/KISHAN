import 'package:constructo/networking/user/controllers/user_controller.dart';
import 'package:constructo/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> checkUserLoggedinToast({
  required VoidCallback callBack,
  VoidCallback? refreshcallBack,
}) async {
  final UserController userController = Get.find();

  if (userController.isLoggedIn) {
    //
    callBack();
  } else {
    // showToastError("Please Login to access this module");

    await AppRoutes.loginScreen();
    if (refreshcallBack != null) {
      refreshcallBack();
    }

    // _showdialogEnterMobile(callBack: callBack);
  }
}
