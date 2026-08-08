import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb5MyProfileScreen extends StatelessWidget with Bnb5MyProfileWidgets {
  Bnb5MyProfileScreen({super.key});

  final Bnb5MyProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: Column(
        children: [
          // Fixed Top Location Header
          profileHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  sizedboxHeight(14),
                  // Profile Body Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.rw),
                    child: Column(
                      children: [
                        // User Profile Card
                        userProfileCard(),
                        sizedboxHeight(14),
                        // Quick Stats Row (My Orders / My Booking)
                        quickStatsRow(),
                        sizedboxHeight(18),
                        // Account Info Section
                        accountInfoSection(controller),
                        sizedboxHeight(18),
                        // General Section
                        generalSection(),
                        sizedboxHeight(30),
                      ],
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
}
