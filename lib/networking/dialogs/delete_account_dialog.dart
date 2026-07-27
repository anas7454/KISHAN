import 'package:constructo_worker/networking/api/endpoints/auth_api_services.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> deleteAccountApi() async {
  bool result2 = await showdialogConfirmation(
    "Alert",
    "Are you sure, you want to delete this account? Your data will not be recoverable in future.",
    btnColorRed: true,
  );
  if (result2 == false) return;

  bool result3 = await showdialogConfirmation(
    "Delete Account",
    "Your data will not be recoverable in future.",
    confirmBtnName: "Confirm",
    btnColorRed: true,
  );
  if (result3 == false) return;

  // isLoading.value = true;

  final Map res = await AuthApiServices.accountDelete();
  if (res["success"]) {
    showToastSuccess(res['msg']);
    UserController userController = Get.find();
    userController.logout();
  } else {
    UserController userController = Get.find();
    userController.logout();
    // showdialogApiError(res["msg"] ?? "Api Success False");
  }
  // isLoading.value = false;
}

Future<bool> showdialogConfirmation(
  String title,
  String text, {
  String? confirmBtnName,
  bool btnColorRed = false,
}) async {
  final showPopUp = await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        // backgroundColor: Colors.white,
        // titlePadding: EdgeInsets.all(22.h).copyWith(bottom: 0.h),
        // contentPadding: EdgeInsets.all(16.h),
        // shape: roundedRectangleBorderDefault(),
        //           backgroundColor: AppColors.cardBg,
        titlePadding: EdgeInsets.all(0.rh),
        contentPadding: EdgeInsets.all(0.rh),
        // title: Center(
        //   child: Text(title, style: AppTextStyles.ts20w700color000000()),
        // ),
        content: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 15.rh),
          decoration: BoxDecoration(
            // image: decorationImageCustom(ImageGredients.homeheaderbg),
            border: borderCustomColorWhite20(),
            borderRadius: borderRadius20(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTextStyles.ts16w600colorFFFFFF()),
              sizedboxHeight(15),
              Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.ts12w400colorWhite(),
              ),

              sizedboxHeight(15),

              SizedBox(
                width: getWidth(),
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        name: confirmBtnName ?? "Proceed",

                        btnColor: btnColorRed ? Colors.red : null,
                        // width: getWidth(0.23),
                        height: 38.rh,
                        fontsize: 12.rh,
                        borderRadiusDouble: 100.rr,
                      ),
                    ),
                    sizedboxWidth(10),
                    Expanded(
                      child: Button(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        name: "Back",
                        btnColor: Colors.green,
                        // width: getWidth(0.23),
                        height: 38.rh,
                        fontsize: 12.rh,
                        borderRadiusDouble: 100.rr,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // actionsAlignment: MainAxisAlignment.center,
        // actions: <Widget>[

        // ],
      );
    },
  );

  return showPopUp ?? false;
}
