import 'dart:ui';
import 'package:constructo_worker/utils/internet_connectivity_service/app_connectivity_controller.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const AppConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final AppConnectivityController controller = Get.find();

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Obx(
          () => controller.isNoInternet.value
              ? _NoInternetOverlay(controller: controller)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _NoInternetOverlay extends StatelessWidget {
  final AppConnectivityController controller;

  const _NoInternetOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        type: MaterialType.transparency,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            color: AppColors.black.withValues(alpha: 0.25),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 30.rw),
            child: Container(
              width: getWidth(0.78),
              padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 24.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: borderRadiusDefault(12.rr),
                border: borderCustomDefault(color: AppColors.borderE6E6E6),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.16),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 58.rw,
                    height: 58.rw,
                    decoration: BoxDecoration(
                      color: AppColors.colorRedBGFCEAEB,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      color: AppColors.colorE02E32RedTab,
                      size: 30.rw,
                    ),
                  ),
                  sizedboxHeight(14),
                  Text(
                    "No internet",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.ts20w700color000000(),
                  ),
                  sizedboxHeight(20),
                  Obx(
                    () => SizedBox(
                      width: getWidth(),
                      height: 42.rh,
                      child: ElevatedButton(
                        onPressed: controller.isRetrying.value
                            ? null
                            : controller.retry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ctaBtnColor,
                          disabledBackgroundColor: AppColors.ctaBtnColor
                              .withValues(alpha: 0.5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadiusDefault(8.rr),
                          ),
                        ),
                        child: Text(
                          controller.isRetrying.value ? "Retry..." : "Retry",
                          style: AppTextStyles.ts12w700colorFFFFFF(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
