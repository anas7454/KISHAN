import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/bottomnavbar_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Bnb3HomeWidgets {
  // Top Location Header (AppColors.yellowBg)
  Widget workerHomeHeader(BuildContext context, Bnb3HomeController controller) {
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
          InkWell(
            onTap: AppRoutes.walletScreen,
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
                Icons.account_balance_wallet_outlined,
                color: AppColors.black,
                size: 19.rsp,
              ),
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
  Widget workerProfileCard(Bnb3HomeController controller) {
    return Obx(() {
      final bool isKycApproved = controller.isKycApproved.value;
      final String profileImage = controller.workerProfileImage.value;
      return InkWell(
        onTap: () {
          if (Get.isRegistered<BottomnavbarController>()) {
            Get.find<BottomnavbarController>().selectTab(3);
          }
        },
        borderRadius: BorderRadius.circular(15.rr), // 15px radius Figma spec
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 125.rh,
          ), // Minimum height 125px to prevent vertical overflow
          padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15.rr,
            ), // 15px radius Figma spec
            border: Border.all(
              color: const Color(0xffDCDCDC),
              width: 1.rsp,
            ), // 1px #DCDCDC border Figma spec
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffFFF1BA), // #FFF1BA gradient start Figma spec
                Color(0xffFFFFFF), // #FFFFFF gradient end Figma spec
              ],
            ),
            image: const DecorationImage(
              image: AssetImage('assets/dummy_images/crane_bg.jpg'),
              fit: BoxFit.cover,
              opacity: 0.08, // 8% opacity faint watermark overlay
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
              sizedboxWidth(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.workerName.value.isNotEmpty
                          ? controller.workerName.value
                          : "Worker",
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
                    if (!isKycApproved)
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
                              "Pending",
                              style: AppTextStyles.ts10w500colorBlack()
                                  .copyWith(
                                    fontSize: 11.rsp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      )
                    else
                      // Profile Verified Badge (Figma Specs: Frame 2085662945, Hug 89x25px, Radius: 4.35px, #35AF30 10% fill)
                      Container(
                        padding: EdgeInsets.only(
                          top: 4.rh,
                          bottom: 4.rh,
                          left: 5.rw,
                          right: 6.rw,
                        ), // Figma padding spec
                        decoration: BoxDecoration(
                          color: const Color(0xff35AF30).withValues(
                            alpha: 0.10,
                          ), // #35AF30 10% fill Figma spec
                          borderRadius: BorderRadius.circular(
                            4.35.rr,
                          ), // 4.35px radius Figma spec
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 13.rsp,
                              color: const Color(
                                0xff35AF30,
                              ), // #35AF30 color Figma spec
                            ),
                            sizedboxWidth(4),
                            Text(
                              "Profile Verified",
                              style: AppTextStyles.ts10w500colorBlack()
                                  .copyWith(
                                    fontSize: 10.5.rsp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(
                                      0xff35AF30,
                                    ), // #35AF30 color Figma spec
                                  ),
                            ),
                          ],
                        ),
                      ),
                    sizedboxHeight(6),
                    Text(
                      "You can now connect with vendor and get work",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp, // 10px Figma spec
                        fontWeight:
                            FontWeight.w500, // Weight 500 Medium Figma spec
                        height: 1.0, // 100% line height Figma spec
                        color: const Color(
                          0xff35AF30,
                        ), // #35AF30 color Figma spec
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Card 2: Status / Action Banner Card (Under Review vs Join a Vendor)
  Widget workerStatusActionCard(Bnb3HomeController controller) {
    return Obx(() {
      final bool isUnderReview = controller.isUnderReview.value;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.rw,
          vertical: 12.rh,
        ), // Top/Bottom 12px, Left/Right 16px Figma spec
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
          border: Border.all(
            color: AppColors.borderDBDBDB,
            width: 1.rsp,
          ), // 1px #DBDBDB border Figma spec
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isUnderReview ? "Under Review" : "Join a Vendor",
                    style: AppTextStyles.ts16w600color000000().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.rsp,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    isUnderReview
                        ? "Our team is reviewing your application.\nYou'll get notified soon"
                        : "Connect with trusted vendor to get regular construction work.",
                    style: AppTextStyles.ts12w500color808080().copyWith(
                      fontSize: 12.rsp,
                      color: AppColors.color7D7D7D,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Action Button (Figma Specs: Frame 2085662967, 76x28px Hug, Radius: 4px, #FFCC00 fill, #FFFFFF text)
            Button(
              name: isUnderReview ? "View Progress" : "Join Now",
              btnColor: AppColors.primary,
              textColor: AppColors.white, // #FFFFFF white text Figma spec
              height: 28.rh, // 28px Hug height Figma spec
              flexibleWidth: true,
              horizontalPadding: 10.rw, // 10px horizontal padding Figma spec
              fontsize: 12.rsp,
              fontWeight: FontWeight.w700,
              borderRadiusDouble: 4.rr, // 4px radius Figma spec
              elevation: 0,
              onPressed: () {
                if (isUnderReview) {
                  AppRoutes.workerRegistrationScreen();
                } else {
                  Get.snackbar(
                    "Join Vendor",
                    "Browsing available vendors...",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.black,
                    colorText: AppColors.white,
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }

  // 3 Key Stats Grid Cards (Figma Specs: Frame 2147227010, 112x118px Hug, Radius: 8px, 12px padding, 6px gap)
  Widget workerKeyStatsGrid(Bnb3HomeController controller) {
    return Obx(
      () => Row(
        children: [
          // Card 1: Job Completed
          Expanded(
            child: Container(
              height: 118.rh, // 118px height Figma spec
              padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  8.rr,
                ), // 8px radius Figma spec
                border: Border.all(
                  color: AppColors.borderDBDBDB,
                  width: 1.rsp,
                ), // 1px #DBDBDB border Figma spec
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32.rw,
                    height: 32.rh,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFF3E0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.work_history_outlined,
                      color: const Color(0xffF57C00),
                      size: 18.rsp,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    '${controller.workerCompletedJobs.value}',
                    style: AppTextStyles.ts18w700color000000().copyWith(
                      fontSize: 16.rsp,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    "Job Completed",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts12w500colorBlack().copyWith(
                      fontSize: 10.5.rsp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    "View History",
                    style: AppTextStyles.ts10w500colorBlack().copyWith(
                      fontSize: 10.rsp,
                      color: const Color(0xffF57C00),
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sizedboxWidth(8),
          // Card 2: Enring (Earnings)
          Expanded(
            child: InkWell(
              onTap: AppRoutes.walletScreen,
              borderRadius: BorderRadius.circular(8.rr),
              child: Container(
                height: 118.rh, // 118px height Figma spec
                padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    8.rr,
                  ), // 8px radius Figma spec
                  border: Border.all(
                    color: AppColors.borderDBDBDB,
                    width: 1.rsp,
                  ), // 1px #DBDBDB border Figma spec
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32.rw,
                      height: 32.rh,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8F5E9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: const Color(0xff16A34A),
                        size: 18.rsp,
                      ),
                    ),
                    sizedboxHeight(6), // 6px gap Figma spec
                    Text(
                      '₹${controller.workerTotalEarnings.value.toStringAsFixed(0)}',
                      style: AppTextStyles.ts18w700color000000().copyWith(
                        fontSize: 16.rsp,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    sizedboxHeight(6), // 6px gap Figma spec
                    Text(
                      "Earnings",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 10.5.rsp,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                    sizedboxHeight(6), // 6px gap Figma spec
                    Text(
                      "View Wallet",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: const Color(0xff16A34A),
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          sizedboxWidth(8),
          // Card 3: Active Requests
          Expanded(
            child: Container(
              height: 118.rh, // 118px height Figma spec
              padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  8.rr,
                ), // 8px radius Figma spec
                border: Border.all(
                  color: AppColors.borderDBDBDB,
                  width: 1.rsp,
                ), // 1px #DBDBDB border Figma spec
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32.rw,
                    height: 32.rh,
                    decoration: const BoxDecoration(
                      color: Color(0xffE3F2FD),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: const Color(0xff1976D2),
                      size: 18.rsp,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    '${controller.pendingBookings.length}',
                    style: AppTextStyles.ts18w700color000000().copyWith(
                      fontSize: 16.rsp,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    "Active Requests",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts12w500colorBlack().copyWith(
                      fontSize: 10.5.rsp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  sizedboxHeight(6), // 6px gap Figma spec
                  Text(
                    "View Request",
                    style: AppTextStyles.ts10w500colorBlack().copyWith(
                      fontSize: 10.rsp,
                      color: const Color(0xff1976D2),
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Ongoing Project Card (Figma Specs: Frame 2085662967, 360x90px, Radius: 8px, #FEF8F2 fill, #FFDEBD border)
  Widget ongoingProjectCard(Bnb3HomeController controller) {
    return Obx(() {
      final booking = controller.ongoingBooking.value;
      if (booking == null) return const SizedBox.shrink();
      final String status = booking.status.isEmpty
          ? 'In Progress'
          : booking.status
                .toLowerCase()
                .split('_')
                .map(
                  (word) => word.isEmpty
                      ? word
                      : '${word[0].toUpperCase()}${word.substring(1)}',
                )
                .join(' ');
      final String projectMeta = <String>[
        booking.address,
        booking.displayStartDate,
      ].where((value) => value.isNotEmpty).join('  ');
      return InkWell(
        onTap: () => AppRoutes.requestDetailsScreen(bookingId: booking.id),
        borderRadius: BorderRadius.circular(8.rr),
        child: Container(
          width: double.infinity,
          height: 90.rh, // 90px height Figma spec
          padding: EdgeInsets.symmetric(
            horizontal: 8.rw,
            vertical: 8.rh,
          ), // Padding to fit 74px height thumbnail
          decoration: BoxDecoration(
            color: const Color(0xffFEF8F2), // #FEF8F2 background Figma spec
            borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
            border: Border.all(
              color: const Color(0xffFFDEBD),
              width: 1.rsp,
            ), // 1px #FFDEBD border Figma spec
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Project Thumbnail Image
              Container(
                width: 74.rw, // 74px width thumbnail
                height: 74.rh, // 74px height thumbnail
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.rr),
                  image: const DecorationImage(
                    image: AssetImage(ImageUtility.ima1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sizedboxWidth(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // In Progress Badge (Figma Specs: Frame 2085662945, Hug 57x18px, Radius: 3px, #F57D07 10% fill, 0.5px #F57D07 border)
                    Container(
                      padding: EdgeInsets.only(
                        top: 3.35.rh,
                        bottom: 3.35.rh,
                        left: 5.rw,
                        right: 6.rw,
                      ), // Figma padding spec
                      decoration: BoxDecoration(
                        color: const Color(0xffF57D07).withValues(
                          alpha: 0.10,
                        ), // #F57D07 10% fill Figma spec
                        borderRadius: BorderRadius.circular(
                          3.rr,
                        ), // 3px radius Figma spec
                        border: Border.all(
                          color: const Color(0xffF57D07),
                          width: 0.5.rsp,
                        ), // 0.5px border Figma spec
                      ),
                      child: Text(
                        status,
                        style: AppTextStyles.ts10w500colorBlack().copyWith(
                          fontSize: 9.rsp,
                          color: const Color(
                            0xffF57D07,
                          ), // #F57D07 color Figma spec
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                        ),
                      ),
                    ),
                    sizedboxHeight(4),
                    Text(
                      booking.title,
                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.rsp,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      projectMeta,
                      style: AppTextStyles.ts12w500color808080().copyWith(
                        fontSize: 11.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Vendor Request Item Widget (Clean list item with no individual border)
  Widget vendorRequestItem({
    required String name,
    required String date,
    required String status,
    required Color statusBg,
    required Color statusColor,
    bool showDivider = true,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap ?? () => AppRoutes.requestDetailsScreen(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.rh),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vendor Thumbnail Image
                Container(
                  width: 44.rw,
                  height: 44.rh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.rr),
                    image: const DecorationImage(
                      image: AssetImage(ImageUtility.ima1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                sizedboxWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.ts14w600colorBlack().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5.rsp,
                        ),
                      ),
                      sizedboxHeight(4),
                      Row(
                        children: [
                          Text(
                            "Requested",
                            style: AppTextStyles.ts12w500color808080().copyWith(
                              fontSize: 11.rsp,
                              color: AppColors.color7D7D7D,
                            ),
                          ),
                          sizedboxWidth(12),
                          Text(
                            date,
                            style: AppTextStyles.ts12w500color808080().copyWith(
                              fontSize: 11.rsp,
                              color: AppColors.color7D7D7D,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status Badge (Figma Specs: Frame 2085662967, Fixed 82px width, 28px height, 4px radius)
                Container(
                  width: 82.rw, // 82px width Figma spec
                  height: 28.rh, // 28px height Figma spec
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(
                      4.rr,
                    ), // 4px radius Figma spec
                  ),
                  child: Text(
                    status,
                    style: AppTextStyles.ts12w500colorBlack().copyWith(
                      fontSize: 11.rsp,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
      ],
    );
  }

  // My Vendor Requested Section Widget
  Widget myVendorRequestedSection(Bnb3HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Vendor Requested",
          style: AppTextStyles.ts18w700color000000().copyWith(
            fontSize: 15.rsp,
            fontWeight: FontWeight.w800,
          ),
        ),
        sizedboxHeight(6),
        if (controller.isBookingsLoading.value &&
            controller.pendingBookings.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(color: AppColors.primary),
          )
        else if (controller.pendingBookings.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.rh),
            child: Text(
              'No pending requests',
              style: AppTextStyles.ts12w500color808080(),
            ),
          )
        else
          ...controller.pendingBookings.indexed.map((entry) {
            final int index = entry.$1;
            final booking = entry.$2;
            return vendorRequestItem(
              name: booking.customerName,
              date: booking.displayRequestedOn,
              status: "New",
              statusBg: const Color(0xffFFF7D0),
              statusColor: const Color(0xffE5A93B),
              showDivider: index != controller.pendingBookings.length - 1,
              onTap: () =>
                  AppRoutes.requestDetailsScreen(bookingId: booking.id),
            );
          }),
      ],
    );
  }

  // Verification Steps List (Visible when Under Review)
  Widget verificationStepsList() {
    return Column(
      children: [
        _verificationStepTile("Personal Info", isVerified: true),
        _verificationStepTile("Bank Info", isVerified: false, showEdit: true),
        _verificationStepTile(
          "Document's Uploaded",
          isVerified: false,
          showEdit: true,
        ),
        _verificationStepTile(
          "Document's Uploaded",
          isVerified: false,
          showEdit: true,
        ),
        _verificationStepTile("Selfie Verification", isVerified: true),
        _verificationStepTile(
          "Skills & Experience / Certificate Info",
          isVerified: true,
        ),
        _verificationStepTile("Availability", isVerified: true),
      ],
    );
  }

  // Individual Verification Step Tile
  Widget _verificationStepTile(
    String title, {
    required bool isVerified,
    bool showEdit = false,
  }) {
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
              color: const Color(0xffD32F2F), // Red edit icon
              size: 20.rsp,
            ),
            sizedboxWidth(12),
          ],
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
            decoration: BoxDecoration(
              color: isVerified
                  ? const Color(0xffE6F5E9)
                  : const Color(0xffFFEBEE),
              borderRadius: BorderRadius.circular(4.rr),
            ),
            child: Text(
              isVerified ? "Verified" : "Rejected",
              style: AppTextStyles.ts10w500colorBlack().copyWith(
                fontSize: 10.rsp,
                fontWeight: FontWeight.w600,
                color: isVerified
                    ? const Color(0xff35AF30)
                    : const Color(0xffD32F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // New Requests Section
  Widget newRequestsSection(Bnb3HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New Requests",
          style: AppTextStyles.ts18w700color000000().copyWith(
            fontSize: 16.rsp,
            fontWeight: FontWeight.w800,
          ),
        ),
        sizedboxHeight(12),
        if (controller.isBookingsLoading.value &&
            controller.pendingBookings.isEmpty)
          const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          )
        else if (controller.pendingBookings.isEmpty)
          Text(
            'No pending requests',
            style: AppTextStyles.ts12w500color808080(),
          )
        else
          ...controller.pendingBookings.map(
            (booking) => workerRequestCard(
              title: booking.title,
              requestId: booking.requestId,
              date: booking.displayRequestedOn,
              amount: booking.amount.startsWith('₹')
                  ? booking.amount
                  : '₹${booking.amount}',
              address: booking.address,
              status: WorkerRequestStatus.newRequest,
              onTap: () =>
                  AppRoutes.requestDetailsScreen(bookingId: booking.id),
              onAccept: () => controller.acceptBooking(booking),
              onReject: () => controller.rejectBooking(booking),
              isAccepting:
                  controller.processingBookingId.value == booking.id &&
                  controller.processingAction.value == 'accept',
              isRejecting:
                  controller.processingBookingId.value == booking.id &&
                  controller.processingAction.value == 'reject',
              onViewMap: () {},
            ),
          ),
      ],
    );
  }
}
