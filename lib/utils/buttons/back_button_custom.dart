import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable Back Button Widget — Same style as OTP screen back button.
/// White circle, #E6E6E6 border, subtle shadow, arrow_back_rounded icon.
/// Used across: AuthScaffold, EditProfile, WorkerRegistration, AppBars.
class BackButtonCustom extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonCustom({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back<void>(),
      child: Container(
        width: 40.rw,
        height: 40.rh,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.borderE6E6E6,
            width: 1.rsp,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.black,
          size: 20.rsp,
        ),
      ),
    );
  }
}
