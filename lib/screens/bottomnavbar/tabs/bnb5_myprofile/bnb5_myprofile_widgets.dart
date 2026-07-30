import 'package:constructo_worker/networking/user/auth/logout_showdialog.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_controller.dart';
import 'package:constructo_worker/utils/images/image_utility/dummy_images_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Bnb5MyProfileWidgets {
  // 1. Top Location Bar Header
  Widget profileHeader(BuildContext context) {
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
              onTap: () {
                AppRoutes.homeLocationSearchScreen();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Location",
                    style: AppTextStyles.ts12w500color000000().copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  sizedboxHeight(2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                      sizedboxWidth(4),
                      Flexible(
                        child: Text(
                          "Patna Bihar, 245768",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts12w500color808080().copyWith(
                            color: AppColors.color7D7D7D,
                          ),
                        ),
                      ),
                      sizedboxWidth(4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sizedboxWidth(8.rw),
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

  // 2. User Profile Card (Exact Figma Specs: 360x89px, Radius: 21.18px, Border: 1.06px #EEEEEE, Padding: 15.88px/21.18px, Gap: 8.47px)
  Widget userProfileCard() {
    return Container(
      width: double.infinity,
      height: 89.rh,
      padding: EdgeInsets.only(
        top: 15.88.rh,
        right: 21.18.rw,
        bottom: 15.88.rh,
        left: 15.88.rw,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(21.18.rr),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.06.rsp),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Container(
            width: 57.24.rw,
            height: 57.24.rw,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(DummyImagesUtility.workerprofile),
                fit: BoxFit.cover,
              ),
            ),
          ),
          sizedboxWidth(8.47.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Adity Birla",
                  style: AppTextStyles.ts16w600color000000().copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.rsp,
                  ),
                ),
                sizedboxHeight(2),
                Text(
                  "abidsf@gmail.com",
                  style: AppTextStyles.ts12w500color808080().copyWith(
                    color: AppColors.color7D7D7D,
                    fontSize: 12.5.rsp,
                  ),
                ),
              ],
            ),
          ),
          sizedboxWidth(8.47.rw),
          // Edit Yellow Pill Button (Exact Figma Specs: 76x32px Hug, Radius: Pill, Padding: 7px 25px, #FFCC00 fill)
          GestureDetector(
            onTap: () {
              AppRoutes.editProfileScreen();
            },
            child: Container(
              width: 76.rw,
              height: 32.rh,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.rw, vertical: 7.rh),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100.rr),
              ),
              child: Text(
                "Edit",
                style: AppTextStyles.ts14w600colorBlack().copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.rsp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Quick Stats Cards (My Orders / My Booking - Exact Figma Specs: 173.65x58.24px, Radius: 12.71px, Border: 1.06px #614B8B 10%, Padding: 10.59px, Gap: 8.47px, Shadow: 4.24 Blur #F5BD4C 5%)
  Widget quickStatsRow() {
    return Row(
      children: [
        // My Orders Card
        Expanded(
          child: Container(
            height: 58.24.rh,
            padding: EdgeInsets.all(10.59.rw),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.71.rr),
              border: Border.all(color: const Color(0x1A614B8B), width: 1.06.rsp),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0CF5BD4C),
                  offset: Offset.zero,
                  blurRadius: 4.24.rr,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 37.06.rw,
                  height: 37.06.rw,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFDFF),
                    borderRadius: BorderRadius.circular(5.rr),
                    border: Border.all(color: const Color(0xFFE2EEF5), width: 1.rsp),
                  ),
                  child: Icon(
                    Icons.credit_card_rounded,
                    color: const Color(0xffFFBC07),
                    size: 20.rsp,
                  ),
                ),
                sizedboxWidth(8.47.rw),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "My Orders",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts12w500color000000().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.rsp,
                          ),
                        ),
                        Text(
                          "145",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts16w600color000000().copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.rsp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.black,
                  size: 18.rsp,
                ),
              ],
            ),
          ),
        ),
        sizedboxWidth(8.47.rw),
        // My Booking Card
        Expanded(
          child: Container(
            height: 58.24.rh,
            padding: EdgeInsets.all(10.59.rw),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.71.rr),
              border: Border.all(color: const Color(0x1A614B8B), width: 1.06.rsp),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0CF5BD4C),
                  offset: Offset.zero,
                  blurRadius: 4.24.rr,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 37.06.rw,
                  height: 37.06.rw,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFDFF),
                    borderRadius: BorderRadius.circular(5.rr),
                    border: Border.all(color: const Color(0xFFE2EEF5), width: 1.rsp),
                  ),
                  child: Icon(
                    Icons.hexagon_outlined,
                    color: const Color(0xffFFBC07),
                    size: 20.rsp,
                  ),
                ),
                sizedboxWidth(8.47.rw),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "My Booking",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts12w500color000000().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.rsp,
                          ),
                        ),
                        Text(
                          "02",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts16w600color000000().copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.rsp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.black,
                  size: 18.rsp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 4. Account Info Section
  Widget accountInfoSection(Bnb5MyProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Info",
          style: AppTextStyles.ts16w600color000000().copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.rsp,
          ),
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.hexagon_outlined,
          title: "Account Setting",
          subtitle: "Make changes to your account",
          onTap: () {
            AppRoutes.editProfileScreen();
          },
        ),
      ],
    );
  }

  // 5. General Section
  Widget generalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "General",
          style: AppTextStyles.ts16w600color000000().copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.rsp,
          ),
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.help_outline_rounded,
          title: "About App",
          subtitle: "Read about us details & services",
          onTap: () => AppRoutes.aboutAppScreen(),
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.description_outlined,
          title: "Terms & Conditions",
          subtitle: "Read our terms of service",
          onTap: () => AppRoutes.termsAndConditionsScreen(),
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.shield_outlined,
          title: "Privacy Policy",
          subtitle: "How we protect your data",
          onTap: () => AppRoutes.privacyPolicyScreen(),
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.headset_mic_outlined,
          title: "Report & Issue",
          subtitle: "Get help and support",
          onTap: () {},
        ),
        sizedboxHeight(10),
        profileOptionTile(
          icon: Icons.logout_rounded,
          title: "Logout",
          subtitle: "Sign out of your account",
          onTap: () {
            clickLogoutBtn();
          },
        ),
      ],
    );
  }

  // Reusable Option Tile Widget (Exact Figma Specs: 360x56px, Radius: 10px, Border: 1px #EEEEEE, Padding: 6px 15px 6px 8px, Gap: 10px)
  Widget profileOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.rh,
        padding: EdgeInsets.only(
          top: 6.rh,
          right: 15.rw,
          bottom: 6.rh,
          left: 8.rw,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.rr),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1.rsp),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.rw,
              height: 44.rh,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFDFF),
                borderRadius: BorderRadius.circular(8.rr),
                border: Border.all(color: const Color(0xFFE2EEF5), width: 1.rsp),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: const Color(0xffFFBC07),
                size: 20.rsp,
              ),
            ),
            sizedboxWidth(10.rw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.rsp,
                    ),
                  ),
                  sizedboxHeight(1),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts11w400color808080().copyWith(
                      color: AppColors.color7D7D7D,
                      fontSize: 11.5.rsp,
                    ),
                  ),
                ],
              ),
            ),
            sizedboxWidth(6.rw),
            trailing ??
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.black,
                  size: 18.rsp,
                ),
          ],
        ),
      ),
    );
  }
}
