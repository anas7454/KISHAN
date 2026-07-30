import 'package:constructo_worker/screens/edit_profile/edit_profile_controller.dart';
import 'package:constructo_worker/screens/edit_profile/edit_profile_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget with EditProfileWidgets {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: Column(
        children: [
          // App Bar
          editProfileAppBar(context),
          // Body Form Content
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.all(16.rw),
              child: Column(
                children: [
                  sizedboxHeight(8),
                  // Profile Photo Section
                  profileAvatarSection(controller),
                  sizedboxHeight(20),
                  // Form Card Container
                  Container(
                    padding: EdgeInsets.all(16.rw),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.rr),
                      border: Border.all(color: const Color(0xFFEEEEEE), width: 1.rsp),
                    ),
                    child: Column(
                      children: [
                        // Full Name
                        editInputField(
                          label: "Full Name",
                          hintText: "Enter full name",
                          controller: controller.fullNameController,
                        ),
                        sizedboxHeight(14),
                        // Mobile Number (Verified)
                        editInputField(
                          label: "Mobile Number",
                          hintText: "Enter mobile number",
                          controller: controller.phoneController,
                          readOnly: true,
                          suffixIcon: Icon(
                            Icons.verified_user_rounded,
                            color: const Color(0xFF4CAF50),
                            size: 20.rsp,
                          ),
                        ),
                        sizedboxHeight(14),
                        // Email Address
                        editInputField(
                          label: "Email Address",
                          hintText: "Enter email address",
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        sizedboxHeight(14),
                        // Date of Birth
                        editInputField(
                          label: "Date of Birth",
                          hintText: "Select DOB",
                          controller: controller.dobController,
                          readOnly: true,
                          onTap: () => controller.pickDateOfBirth(context),
                          suffixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: AppColors.color7D7D7D,
                            size: 18.rsp,
                          ),
                        ),
                        sizedboxHeight(14),
                        // Gender Selection
                        genderSelector(controller),
                        sizedboxHeight(14),
                        // Language
                        editInputField(
                          label: "Primary Language",
                          hintText: "Select language",
                          controller: controller.languageController,
                        ),
                        sizedboxHeight(14),
                        // State & City
                        Row(
                          children: [
                            Expanded(
                              child: editInputField(
                                label: "State",
                                hintText: "State",
                                controller: controller.stateController,
                              ),
                            ),
                            sizedboxWidth(10),
                            Expanded(
                              child: editInputField(
                                label: "City",
                                hintText: "City",
                                controller: controller.cityController,
                              ),
                            ),
                          ],
                        ),
                        sizedboxHeight(14),
                        // Address
                        editInputField(
                          label: "Full Address",
                          hintText: "Enter full address",
                          controller: controller.addressController,
                        ),
                      ],
                    ),
                  ),
                  sizedboxHeight(20),
                ],
              ),
            ),
          ),
          // Save Button Section
          saveButtonSection(controller),
        ],
      ),
    );
  }
}
