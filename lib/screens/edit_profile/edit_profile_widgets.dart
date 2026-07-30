import 'dart:io';

import 'package:constructo_worker/screens/edit_profile/edit_profile_controller.dart';
import 'package:constructo_worker/utils/buttons/back_button_custom.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/dummy_images_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

mixin EditProfileWidgets {
  // App Bar Widget - Same style as profile screen header (yellowBg, same padding)
  Widget editProfileAppBar(BuildContext context) {
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
          const BackButtonCustom(),
          sizedboxWidth(12.rw),
          Text(
            "Edit Profile",
            style: AppTextStyles.ts18w700color000000(),
          ),
        ],
      ),
    );
  }

  // Profile Photo Card with Camera Edit Overlay
  Widget profileAvatarSection(EditProfileController controller) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Obx(() {
            final String path = controller.profileImagePath.value;
            final bool hasCustomImage = path.isNotEmpty && File(path).existsSync();

            return Container(
              width: 100.rw,
              height: 100.rw,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2.rsp),
                image: DecorationImage(
                  image: hasCustomImage
                      ? FileImage(File(path)) as ImageProvider
                      : AssetImage(DummyImagesUtility.workerprofile),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: controller.showImagePickerBottomSheet,
            child: Container(
              padding: EdgeInsets.all(8.rw),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2.rsp),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: AppColors.black,
                size: 16.rsp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Form Field Component - Same as personal info inputLabelField (Figma Specs: Height: 44px, Radius: 10px, Border: 1px #D7D7D7, Padding: 9px 10px, Gap: 7px, LinearGradient background)
  Widget editInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    Widget? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.words,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.ts14w600colorBlack().copyWith(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedboxHeight(7),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 44.rh,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 9.rh),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(51, 51, 51, 0.03),
                  Color.fromRGBO(0, 0, 0, 0.03),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x2EFFFFFF),
                  offset: Offset(0, 3.rh),
                  blurRadius: 4.rr,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(color: AppColors.borderTextfiled, width: 1.rsp),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onTap,
                    keyboardType: keyboardType,
                    textCapitalization: textCapitalization,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    style: AppTextStyles.ts14w400color000000(),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: AppTextStyles.ts14w500color7D7D7D(),
                      border: InputBorder.none,
                      counterText: "",
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                ?suffixIcon,
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Gender Selector Component
  Widget genderSelector(EditProfileController controller) {
    final List<String> genders = ['Male', 'Female', 'Other'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: AppTextStyles.ts14w600colorBlack().copyWith(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedboxHeight(7),
        Obx(
          () => Row(
            children: genders.map((g) {
              final bool isSelected = controller.selectedGender.value == g;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: g != genders.last ? 8.rw : 0),
                  child: GestureDetector(
                    onTap: () => controller.setGender(g),
                    child: Container(
                      height: 42.rh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.yellowBg : AppColors.white,
                        borderRadius: BorderRadius.circular(10.rr),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.borderTextfiled,
                          width: isSelected ? 1.5.rsp : 1.rsp,
                        ),
                      ),
                      child: Text(
                        g,
                        style: AppTextStyles.ts14w600colorBlack().copyWith(
                          color: isSelected ? AppColors.black : AppColors.color7D7D7D,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 13.rsp,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Bottom Save Button Container
  Widget saveButtonSection(EditProfileController controller) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.borderE6E6E6, width: 1.rsp)),
      ),
      child: SafeArea(
        top: false,
        child: Button(
          name: "Save Changes",
          onPressed: controller.saveProfileChanges,
        ),
      ),
    );
  }
}
