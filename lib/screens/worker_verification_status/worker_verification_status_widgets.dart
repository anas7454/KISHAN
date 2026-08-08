import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/worker_verification_status/worker_verification_status_controller.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin WorkerVerificationStatusWidgets {
  // Top Location Header
  Widget verificationHeader(BuildContext context, WorkerVerificationStatusController controller) {
    return Container(
      color: AppColors.yellowBg,
      padding: EdgeInsets.only(
        left: 16.rw,
        right: 16.rw,
        top: MediaQuery.paddingOf(context).top + 8.rh,
        bottom: 12.rh,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: AppRoutes.homeLocationSearchScreen,
              borderRadius: BorderRadius.circular(8.rr),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.rh),
                  Obx(() {
                    final location = controller.globalController.userLocation.value;
                    final loading = controller.globalController.isLocationLoading.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        assetImageWidget(CommonIconsUtility.location, size: 10.rh),
                        SizedBox(width: 4.rw),
                        Flexible(
                          child: Text(
                            loading ? 'Finding your location...' : (location.displayAddress.isNotEmpty ? location.displayAddress : 'Patna Bihar, 245768'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.ts10w400color7D7D7D().copyWith(
                              fontSize: 11.rsp,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16.rsp,
                          color: AppColors.color7D7D7D,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          // Wallet / Passbook button
          Container(
            width: 36.rw,
            height: 36.rh,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.black,
              size: 19.rsp,
            ),
          ),
          sizedboxWidth(8),
          // Notification button
          Container(
            width: 36.rw,
            height: 36.rh,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.black,
              size: 20.rsp,
            ),
          ),
        ],
      ),
    );
  }

  // Worker Profile Header Card
  Widget workerProfileCard(WorkerVerificationStatusController controller) {
    return Obx(() {
      final bool isUnderReview = controller.isUnderReview.value;
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 125.rh),
        padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.rr),
          border: Border.all(color: const Color(0xffDCDCDC), width: 1.rsp),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFFF1BA),
              Color(0xffFFFFFF),
            ],
          ),
          image: const DecorationImage(
            image: AssetImage('assets/dummy_images/crane_bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.08,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Worker Selfie Avatar
            Container(
              width: 64.rw,
              height: 64.rh,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffE2E4E5), width: 1.rsp),
                image: const DecorationImage(
                  image: AssetImage('assets/dummy_images/worker_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            sizedboxWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.workerName.value,
                    style: AppTextStyles.ts18w700color000000().copyWith(
                      fontSize: 16.rsp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  sizedboxHeight(2),
                  Text(
                    "${controller.workerRole.value}  ${controller.workerExperience.value}",
                    style: AppTextStyles.ts12w500color808080().copyWith(
                      fontSize: 12.rsp,
                      color: AppColors.color5C5C5C,
                    ),
                  ),
                  sizedboxHeight(6),
                  // Status Badge
                  if (isUnderReview)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(4.rr),
                        border: Border.all(color: const Color(0xffE0E0E0), width: 1.rsp),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 13.rsp,
                            color: AppColors.black,
                          ),
                          sizedboxWidth(4),
                          Text(
                            "Pending",
                            style: AppTextStyles.ts10w500colorBlack().copyWith(
                              fontSize: 11.rsp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.only(top: 4.rh, bottom: 4.rh, left: 5.rw, right: 6.rw),
                      decoration: BoxDecoration(
                        color: const Color(0xff35AF30).withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(4.35.rr),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 13.rsp,
                            color: const Color(0xff35AF30),
                          ),
                          sizedboxWidth(4),
                          Text(
                            "Profile Verified",
                            style: AppTextStyles.ts10w500colorBlack().copyWith(
                              fontSize: 10.5.rsp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff35AF30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  sizedboxHeight(6),
                  Text(
                    "You can now connect with vendor and get work",
                    style: AppTextStyles.ts10w500colorBlack().copyWith(
                      fontSize: 10.rsp,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      color: const Color(0xff35AF30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // Verification Steps List
  Widget verificationStepsList() {
    return Column(
      children: [
        verificationStepTile("Personal Info", isVerified: true),
        verificationStepTile("Bank Info", isVerified: false, showEdit: true),
        verificationStepTile("Document's Uploaded", isVerified: false, showEdit: true),
        verificationStepTile("Document's Uploaded", isVerified: false, showEdit: true),
        verificationStepTile("Selfie Verification", isVerified: true),
        verificationStepTile("Skills & Experience / Certificate Info", isVerified: true),
        verificationStepTile("Availability", isVerified: true),
      ],
    );
  }

  // Individual Verification Step Tile
  Widget verificationStepTile(String title, {required bool isVerified, bool showEdit = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.rh),
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 14.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.ts14w600colorBlack().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 13.rsp,
              ),
            ),
          ),
          if (showEdit) ...[
            Icon(
              Icons.mode_edit_outline_outlined,
              color: const Color(0xffD32F2F),
              size: 20.rsp,
            ),
            sizedboxWidth(12),
          ],
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
            decoration: BoxDecoration(
              color: isVerified ? const Color(0xffE6F5E9) : const Color(0xffFFEBEE),
              borderRadius: BorderRadius.circular(4.rr),
            ),
            child: Text(
              isVerified ? "Verified" : "Rejected",
              style: AppTextStyles.ts10w500colorBlack().copyWith(
                fontSize: 10.rsp,
                fontWeight: FontWeight.w600,
                color: isVerified ? const Color(0xff35AF30) : const Color(0xffD32F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
