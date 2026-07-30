import 'dart:io';

import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/toast/custom_tost_for_mobile.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController {
  // Form Controllers
  final TextEditingController fullNameController = TextEditingController(text: "Adity Birla");
  final TextEditingController phoneController = TextEditingController(text: "+91 9876543210");
  final TextEditingController emailController = TextEditingController(text: "abidsf@gmail.com");
  final TextEditingController dobController = TextEditingController(text: "15/08/1996");
  final TextEditingController languageController = TextEditingController(text: "Hindi");
  final TextEditingController stateController = TextEditingController(text: "Bihar");
  final TextEditingController cityController = TextEditingController(text: "Patna");
  final TextEditingController addressController = TextEditingController(text: "Boring Road, Patna, Bihar - 800001");

  // Reactive Variables
  final RxString profileImagePath = ''.obs;
  final RxString selectedGender = 'Male'.obs;

  final ImagePicker _picker = ImagePicker();

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  // Pick Profile Image from Camera / Gallery
  Future<void> pickProfileImage(ImageSource source) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  // Show Image Source Selection BottomSheet - Same design as personal info upload
  void showImagePickerBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Drag Handle Pill
              Center(
                child: Container(
                  width: 36.rw,
                  height: 4.rh,
                  decoration: BoxDecoration(
                    color: AppColors.colorC4C4C4,
                    borderRadius: BorderRadius.circular(2.rr),
                  ),
                ),
              ),
              sizedboxHeight(14),
              Text(
                "Upload Photo",
                textAlign: TextAlign.center,
                style: AppTextStyles.ts16w600color000000().copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              sizedboxHeight(20),
              Row(
                children: [
                  // Camera Option Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back<void>();
                        final XFile? photo = await _picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 85,
                        );
                        if (photo != null) {
                          profileImagePath.value = photo.path;
                        }
                      },
                      child: Container(
                        height: 100.rh,
                        decoration: BoxDecoration(
                          color: AppColors.colorF5F5F5,
                          borderRadius: BorderRadius.circular(16.rr),
                          border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 32.rsp,
                              color: AppColors.primary,
                            ),
                            sizedboxHeight(8),
                            Text(
                              "Camera",
                              style: AppTextStyles.ts14w600colorBlack().copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  sizedboxWidth(16),
                  // Gallery Option Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back<void>();
                        pickProfileImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.rh),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.rr),
                          border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.rw),
                              decoration: const BoxDecoration(
                                color: Color(0xffFFF3E0),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.photo_library_outlined,
                                color: const Color(0xffF57C00),
                                size: 24.rsp,
                              ),
                            ),
                            sizedboxHeight(8),
                            Text(
                              "Choose from Gallery",
                              style: AppTextStyles.ts12w500colorBlack().copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizedboxHeight(12),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Date of birth picker
  Future<void> pickDateOfBirth(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1996, 8, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  // Save Edit Profile Details
  bool saveProfileChanges() {
    FocusManager.instance.primaryFocus?.unfocus();
    final String fullName = fullNameController.text.trim();
    final String email = emailController.text.trim();

    if (fullName.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter full name",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (fullName.length < 4) {
      showCustomWidthSnackBar(
        "Full Name must contain at least 4 characters",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      showCustomWidthSnackBar(
        "Please enter a valid email address",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    showCustomWidthSnackBar(
      "Profile updated successfully!",
      customWidth: 340.rw,
      bgColor: const Color(0xFF4CAF50),
    );
    Get.back<void>();
    return true;
  }
}
