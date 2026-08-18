import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_screen.dart';
import 'package:constructo_worker/screens/worker_verification_status/worker_verification_status_controller.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin WorkerVerificationStatusWidgets {
  // Top Location Header
  Widget verificationHeader(
    BuildContext context,
    WorkerVerificationStatusController controller,
  ) {
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
                    final location =
                        controller.globalController.userLocation.value;
                    final loading =
                        controller.globalController.isLocationLoading.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        assetImageWidget(
                          CommonIconsUtility.location,
                          size: 10.rh,
                        ),
                        SizedBox(width: 4.rw),
                        Flexible(
                          child: Text(
                            loading
                                ? 'Finding your location...'
                                : (location.displayAddress.isNotEmpty
                                      ? location.displayAddress
                                      : 'Patna Bihar, 245768'),
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
          InkWell(
            onTap: AppRoutes.notificationsScreen,
            customBorder: const CircleBorder(),
            child: Container(
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
          ),
        ],
      ),
    );
  }

  // Worker Profile Header Card
  Widget workerProfileCard(WorkerVerificationStatusController controller) {
    return Obx(() {
      final bool isUnderReview = controller.isUnderReview.value;
      final String overallStatus = controller.overallKycStatus.value;
      final String overallStatusLabel = switch (overallStatus) {
        'UNDER_REVIEW' => 'Under Review',
        'REJECTED' => 'Rejected',
        'APPROVED' => 'Approved',
        'NOT_AVAILABLE' => 'Not Available',
        _ => 'Pending',
      };
      final String profileImage = controller.workerProfileImage.value;
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
            colors: [Color(0xffFFF1BA), Color(0xffFFFFFF)],
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
            GestureDetector(
              onTap: () {
                if (!Get.isRegistered<Bnb5MyProfileController>()) {
                  Get.put(Bnb5MyProfileController());
                }
                Get.to<void>(() => Bnb5MyProfileScreen());
              },
              child: Container(
                width: 64.rw,
                height: 64.rh,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xffE2E4E5),
                    width: 1.rsp,
                  ),
                ),
                child: clipRRectCustom(
                  profileImage.isNotEmpty
                      ? profileImage
                      : 'assets/dummy_images/worker_profile.png',
                  isCircleWidth: 64.rw,
                  boxfit: BoxFit.cover,
                  errorImgasset: 'assets/dummy_images/worker_profile.png',
                  placeholder: 'assets/dummy_images/worker_profile.png',
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
                    controller.workerName.value.isNotEmpty
                        ? controller.workerName.value
                        : 'Worker',
                    style: AppTextStyles.ts18w700color000000().copyWith(
                      fontSize: 16.rsp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (controller.workerRole.value.isNotEmpty ||
                      controller.workerExperience.value.isNotEmpty) ...[
                    sizedboxHeight(2),
                    Text(
                      <String>[
                        controller.workerRole.value,
                        controller.workerExperience.value,
                      ].where((value) => value.isNotEmpty).join('  '),
                      style: AppTextStyles.ts12w500color808080().copyWith(
                        fontSize: 12.rsp,
                        color: AppColors.color5C5C5C,
                      ),
                    ),
                  ],
                  sizedboxHeight(6),
                  // Status Badge
                  if (isUnderReview)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.rw,
                        vertical: 3.rh,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(4.rr),
                        border: Border.all(
                          color: const Color(0xffE0E0E0),
                          width: 1.rsp,
                        ),
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
                            "Overall KYC: $overallStatusLabel",
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
                      padding: EdgeInsets.only(
                        top: 4.rh,
                        bottom: 4.rh,
                        left: 5.rw,
                        right: 6.rw,
                      ),
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
                            "Overall KYC: Approved",
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
                    isUnderReview
                        ? "Your KYC verification is currently $overallStatusLabel"
                        : "You can now connect with vendor and get work",
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

  Widget verificationLoadingSkeleton() {
    Widget skeletonBox({required double height, double radius = 8}) {
      return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xffE8E8E8),
          borderRadius: BorderRadius.circular(radius.rr),
        ),
      );
    }

    return Column(
      children: [
        skeletonBox(height: 125.rh, radius: 15),
        sizedboxHeight(12),
        ...List<Widget>.generate(
          6,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: 10.rh),
            child: skeletonBox(height: 58.rh),
          ),
        ),
      ],
    );
  }

  // Verification Steps List
  Widget verificationStepsList(WorkerVerificationStatusController controller) {
    return Column(
      children: [
        verificationStepTile(
          "Personal Info",
          status: controller.sectionStatus(0),
          remark: controller.sectionRemark(0),
          onTap: () => controller.openKycSection(0, 1),
        ),
        verificationStepTile(
          "Bank Info",
          status: controller.sectionStatus(1),
          remark: controller.sectionRemark(1),
          onTap: () => controller.openKycSection(1, 2),
        ),
        verificationStepTile(
          "Document's Uploaded",
          status: controller.sectionStatus(2),
          remark: controller.sectionRemark(2),
          onTap: () => controller.openKycSection(2, 3),
        ),
        verificationStepTile(
          "Selfie Verification",
          status: controller.sectionStatus(3),
          remark: controller.sectionRemark(3),
          onTap: () => controller.openKycSection(3, 4),
        ),
        verificationStepTile(
          "Skills & Experience / Certificate Info",
          status: controller.sectionStatus(4),
          remark: controller.sectionRemark(4),
          onTap: () => controller.openKycSection(4, 6),
        ),
        verificationStepTile(
          "Availability",
          status: controller.sectionStatus(5),
          remark: controller.sectionRemark(5),
          onTap: () => controller.openKycSection(5, 7),
        ),
      ],
    );
  }

  // Individual Verification Step Tile
  Widget verificationStepTile(
    String title, {
    required String status,
    String remark = '',
    VoidCallback? onTap,
  }) {
    final String normalizedStatus = status.toUpperCase();
    final bool isVerified =
        normalizedStatus == 'APPROVED' ||
        normalizedStatus == 'VERIFIED' ||
        normalizedStatus == 'COMPLETED';
    final bool isRejected = normalizedStatus == 'REJECTED';
    final String statusText = switch (normalizedStatus) {
      'APPROVED' || 'VERIFIED' || 'COMPLETED' => 'Verified',
      'REJECTED' => 'Rejected',
      'UNDER_REVIEW' => 'Under Review',
      'NOT_AVAILABLE' => 'Not Available',
      _ => 'Pending',
    };
    final bool isUnderReview = normalizedStatus == 'UNDER_REVIEW';
    final Color statusColor = isVerified
        ? const Color(0xff35AF30)
        : isRejected
        ? const Color(0xffD32F2F)
        : isUnderReview
        ? const Color(0xffD97706)
        : const Color(0xff7D7D7D);
    final Color statusBackground = isVerified
        ? const Color(0xffE6F5E9)
        : isRejected
        ? const Color(0xffFFEBEE)
        : isUnderReview
        ? const Color(0xffFEF3C7)
        : const Color(0xffF4F4F4);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.rsp,
                    ),
                  ),
                  if (isRejected && remark.isNotEmpty) ...[
                    sizedboxHeight(3),
                    Text(
                      remark,
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        color: const Color(0xffD32F2F),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isRejected) ...[
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
                color: statusBackground,
                borderRadius: BorderRadius.circular(4.rr),
              ),
              child: Text(
                isRejected ? 'Re-upload' : statusText,
                style: AppTextStyles.ts10w500colorBlack().copyWith(
                  fontSize: 10.rsp,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
            sizedboxWidth(8),
            Icon(
              Icons.visibility_outlined,
              color: const Color(0xffFFBC07),
              size: 19.rsp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openKycSectionPreview(
    WorkerVerificationStatusController controller,
    int sectionIndex,
    String title,
  ) async {
    await controller.ensureSectionDataLoaded();
    final Map<String, dynamic> data = controller.sectionData(sectionIndex);
    final List<MapEntry<String, dynamic>> details =
        <MapEntry<String, dynamic>>[];
    _flattenDetails(data, details);

    Get.bottomSheet<void>(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.86),
        padding: EdgeInsets.fromLTRB(16.rw, 12.rh, 16.rw, 20.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.rr)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.rw,
              height: 4.rh,
              decoration: BoxDecoration(
                color: AppColors.borderDBDBDB,
                borderRadius: BorderRadius.circular(4.rr),
              ),
            ),
            sizedboxHeight(12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$title Preview',
                    style: AppTextStyles.ts18w700color000000(),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back<void>(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            _previewStatusRow(
              controller.sectionStatus(sectionIndex),
              controller.sectionRemark(sectionIndex),
            ),
            Divider(color: AppColors.borderDBDBDB),
            Flexible(
              child: details.isEmpty
                  ? Center(
                      child: Text(
                        'No details available',
                        style: AppTextStyles.ts14w600colorBlack(),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: details.length,
                      separatorBuilder: (_, index) =>
                          Divider(color: AppColors.borderE6E6E6),
                      itemBuilder: (_, int index) =>
                          _previewDetail(details[index]),
                    ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _previewStatusRow(String status, String remark) {
    final String label = status == 'UNDER_REVIEW'
        ? 'Under Review'
        : _fieldLabel(status.toLowerCase());
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.rw),
      decoration: BoxDecoration(
        color: AppColors.yellowBg,
        borderRadius: BorderRadius.circular(8.rr),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status: $label',
            style: AppTextStyles.ts12w500color000000().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (remark.isNotEmpty) ...[
            sizedboxHeight(4),
            Text('Remark: $remark', style: AppTextStyles.ts12w500color808080()),
          ],
        ],
      ),
    );
  }

  Widget _previewDetail(MapEntry<String, dynamic> detail) {
    final String value = detail.value?.toString().trim() ?? '';
    final bool isUrl =
        value.startsWith('http://') || value.startsWith('https://');
    final String cleanUrl = value.split('?').first.toLowerCase();
    final bool isImage =
        isUrl &&
        <String>['.jpg', '.jpeg', '.png', '.webp'].any(cleanUrl.endsWith);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _fieldLabel(detail.key),
            style: AppTextStyles.ts12w500color808080(),
          ),
          sizedboxHeight(5),
          if (isImage)
            clipRRectCustom(
              value,
              width: double.infinity,
              height: 180.rh,
              borderR: 8.rr,
              boxfit: BoxFit.cover,
              ontap: true,
            )
          else if (isUrl)
            InkWell(
              onTap: () => UrlLaunchMethods.launchStringINAppOrBrowser(value),
              child: Text(
                'Preview Document',
                style: AppTextStyles.ts12w500color000000().copyWith(
                  color: const Color(0xffFFBC07),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          else
            Text(value, style: AppTextStyles.ts14w600colorBlack()),
        ],
      ),
    );
  }

  void _flattenDetails(
    dynamic value,
    List<MapEntry<String, dynamic>> details, {
    String parentKey = '',
  }) {
    if (value is Map) {
      value.forEach((dynamic key, dynamic nestedValue) {
        final String nestedKey = parentKey.isEmpty
            ? key.toString()
            : '$parentKey ${key.toString()}';
        _flattenDetails(nestedValue, details, parentKey: nestedKey);
      });
      return;
    }
    if (value is List) {
      for (int index = 0; index < value.length; index++) {
        _flattenDetails(
          value[index],
          details,
          parentKey: '$parentKey ${index + 1}',
        );
      }
      return;
    }
    if (value == null || value.toString().trim().isEmpty) return;
    details.add(MapEntry<String, dynamic>(parentKey, value));
  }

  String _fieldLabel(String key) {
    final String label = key
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .replaceAll('_', ' ');
    return label.isEmpty
        ? 'Detail'
        : '${label[0].toUpperCase()}${label.substring(1)}';
  }
}
