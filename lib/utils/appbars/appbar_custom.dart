import 'package:constructo/utils/buttons/icon_button_custom.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:constructo/utils/theme/widgets/divider_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appBarCustom({
  required String title,
  VoidCallback? onBack,
  Color backgroundColor = AppColors.yellowBg,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    elevation: 0,
    centerTitle: false,
    leadingWidth: 44.rw,
    leading: Padding(
      padding: EdgeInsets.only(left: 10.rw),
      child: Center(
        child: IconButtonCustom(
          onPressed: onBack ?? () => Get.back<void>(),

          buttonSize: 35.rh,
          size: 18.rsp,
          iconData: Icons.arrow_back_ios_new_rounded,
          color: AppColors.black,
        ),
      ),
    ),
    titleSpacing: 5.rw,
    title: Text(
      title,
      style: AppTextStyles.ts18w700color000000().copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.rsp),
      child: dividerCustom(color: AppColors.homeCardBorder),
    ),
  );
}
