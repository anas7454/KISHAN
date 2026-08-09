part of '../worker_registration_widgets.dart';

mixin Step8ReviewWidgets on WorkerRegistrationWidgets {
  Widget reviewSectionCard({
    required String title,
    required int sectionIndex,
    required int targetStep,
    required WorkerRegistrationController controller,
    required Widget summaryContent,
  }) {
    return Obx(() {
      final bool isExpanded = controller.expandedSections.toList().contains(sectionIndex);

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.rh),
        padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
          border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp), // 1px #DBDBDB
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.goToStep(targetStep, isFromReview: true),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Edit",
                        style: AppTextStyles.ts12w600color000000().copyWith(
                          color: const Color(0xff16A34A), // Figma exact green
                          fontSize: 13.rsp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      sizedboxWidth(4),
                      Icon(
                        Icons.mode_edit_outline_rounded,
                        color: const Color(0xff16A34A),
                        size: 18.rsp,
                      ),
                    ],
                  ),
                ),
                sizedboxWidth(12),
                GestureDetector(
                  onTap: () => controller.toggleSectionExpanded(sectionIndex),
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.black,
                    size: 22.rsp,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              sizedboxHeight(12),
              Divider(color: AppColors.borderE6E6E6, height: 1.rh),
              sizedboxHeight(12),
              summaryContent,
            ],
          ],
        ),
      );
    });
  }

  // Step 8: Review All Details (Matching Image 2)
  Widget step8ReviewAllDetails(WorkerRegistrationController controller) {
    return Column(
      children: [
        reviewSectionCard(
          title: "Personal Info",
          sectionIndex: 1,
          targetStep: 1,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name: ${controller.fullNameController.text.isNotEmpty ? controller.fullNameController.text : 'Not provided'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "DOB: ${controller.dobController.text.isNotEmpty ? controller.dobController.text : 'Not provided'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "Gender: ${controller.selectedGender.value}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "Language: ${controller.languageController.text.isNotEmpty ? controller.languageController.text : 'Not selected'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Bank Info",
          sectionIndex: 2,
          targetStep: 2,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Holder: ${controller.accountHolderNameController.text.isNotEmpty ? controller.accountHolderNameController.text : 'Not provided'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "IFSC Code: ${controller.ifscCodeController.text.isNotEmpty ? controller.ifscCodeController.text : 'Not provided'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Document's Uploaded",
          sectionIndex: 3,
          targetStep: 3,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Front ID: ${controller.idFrontPath.value}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "Back ID: ${controller.idBackPath.value}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Selfie Verification",
          sectionIndex: 4,
          targetStep: 5,
          controller: controller,
          summaryContent: Text(
            controller.liveSelfiePath.value.isNotEmpty
                ? "Selfie captured successfully"
                : "Selfie verified",
            style: AppTextStyles.ts12w500colorBlack(),
          ),
        ),
        reviewSectionCard(
          title: "Skills & Experience / Certificate Info",
          sectionIndex: 5,
          targetStep: 6,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category: ${controller.selectedSkillCategory.value}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "Experience: ${controller.experienceYearsController.text.isNotEmpty ? controller.experienceYearsController.text : 'Not provided'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Availability",
          sectionIndex: 6,
          targetStep: 7,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Work Type: ${controller.workTypeController.text.isNotEmpty ? controller.workTypeController.text : 'Full Time'}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
              sizedboxHeight(4),
              Text(
                "Working Radius: ${controller.workingRadiusController.text}",
                style: AppTextStyles.ts12w500colorBlack(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 9: Registration Complete Illustration (Figma Specs: 133.89 x 133.89px)
}

