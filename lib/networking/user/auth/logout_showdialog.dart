import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> clickLogoutBtn() async {
  final UserController userController = Get.find();
  if (userController.isLoggedIn) {
    _showdialogLogout();
  } else {
    // go to login
    AppRoutes.loginScreen();
  }
}

Future<bool> _showdialogLogout() async {
  final UserController userController = Get.find<UserController>();
  final showPopUp = await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Obx(() => AlertDialog(
        backgroundColor: AppColors.cardBg,
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.rw),
        shape: roundedRectangleBorderDefault(),

        content: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 15.rh),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 32.rh),
                  // Expanded(
                  //   child: Container(
                  //     height: 170.rh,

                  //     padding: EdgeInsets.only(top: 10.rh),
                  //     child: Image.asset(ImageUtility.logoutimg),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.topRight,
                    child: clearTextfildeIconBtn(
                      onTap: () {
                        if (!userController.isLoggingOut.value) Get.back();
                      },
                    ),
                  ),
                ],
              ),
              sizedboxHeight(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.rw),
                child: Column(
                  children: [
                    Text(
                      "Logout Profile",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.ts22w700color000000(),
                    ),
                    Text(
                      "Do you really want to log out? You’ll need to log in again to continue using the app.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.ts12w400color000000(),
                    ),
                    sizedboxHeight(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                          width: 130.rw,
                          height: 44.rh,
                          onPressed: () {
                            if (!userController.isLoggingOut.value) {
                              Navigator.of(context).pop(true);
                            }
                          },
                          name: 'Not Now',
                          btnType: EnumButtonType.outline,
                          textColor: AppColors.color1D61E7,
                          borderColor: AppColors.color1D61E7,
                          fontsize: 14.rsp,
                          fontWeight: FontWeight.w700,
                        ),
                        Button(
                          width: 130.rw,
                          height: 44.rh,
                          isLoading: userController.isLoggingOut.value,
                          onPressed: () async {
                            await userController.logout(isApiCall: true);
                          },
                          name: 'Yes, Logout',
                          btnColor: Colors.red,
                          fontsize: 14.rsp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    sizedboxHeight(15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    },
  );

  return showPopUp ?? false;
}
