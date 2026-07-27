// api error dialog
import 'package:constructo/networking/dialogs/error_message_hendling.dart';
import 'package:constructo/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showdialogApiError({
  Map respMap = const {},
  String title = '',
  bool restricToDismiss = false,
  String msg = "",
}) {
  return showDialog(
    context: Get.context!,
    barrierDismissible: !restricToDismiss,
    builder: (BuildContext context) {
      return PopScope(
        canPop: !restricToDismiss, // false to restric
        child: AlertDialog(
          backgroundColor: AppColors.cardBg,
          titlePadding: EdgeInsets.all(0.rh),
          contentPadding: EdgeInsets.all(0.rh),
          // shape: roundedRectangleBorderDefault(),
          // title: headingWidget25w700Auth("Message"),
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
                Text("Message", style: AppTextStyles.ts16w600color000000()),
                sizedboxHeight(15),
                Text(
                  getRespMessageFromApi(respMap, msg: msg, isDataShow: true),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.ts12w400color000000(),
                ),
                sizedboxHeight(15),
                Button(
                  onPressed: () {
                    Get.back();
                  },
                  name: 'Close',
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
