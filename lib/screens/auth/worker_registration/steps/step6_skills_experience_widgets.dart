part of '../worker_registration_widgets.dart';

mixin Step6SkillsExperienceWidgets on WorkerRegistrationWidgets {
  Widget skillCategoryGrid(WorkerRegistrationController controller) {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Mason', 'icon': Icons.construction_rounded},
      {'name': 'Electrician', 'icon': Icons.electrical_services_rounded},
      {'name': 'Plumber', 'icon': Icons.plumbing_rounded},
      {'name': 'Painter', 'icon': Icons.format_paint_rounded},
      {'name': 'Carpenter', 'icon': Icons.handyman_rounded},
      {'name': 'Welder', 'icon': Icons.hardware_rounded},
      {'name': 'Helper', 'icon': Icons.engineering_rounded},
      {'name': 'Others', 'icon': Icons.grid_view_rounded},
    ];

    return Obx(() {
      final String selectedCategory = controller.selectedSkillCategory.value; // Read synchronously for Obx

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: skills.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.rh,
          crossAxisSpacing: 8.rw,
          childAspectRatio: 1.0, // Fixed 81x81px square proportion
        ),
        itemBuilder: (context, index) {
          final skill = skills[index];
          final String name = skill['name'] as String;
          final bool isSelected = selectedCategory == name;

          return GestureDetector(
            onTap: () => controller.setSkillCategory(name),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.rh, horizontal: 4.rw),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.yellowBg : AppColors.white,
                borderRadius: BorderRadius.circular(10.rr), // 10px radius Figma spec
                border: Border.all(
                  color: isSelected ? AppColors.primary : const Color(0xffD0D0D0), // #FFCC00 vs #D0D0D0 Figma spec
                  width: 1.rsp,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    skill['icon'] as IconData,
                    size: 26.rsp,
                    color: isSelected ? AppColors.primary : AppColors.black,
                  ),
                  sizedboxHeight(7), // 7px gap Figma spec
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts12w500colorBlack().copyWith(
                      color: isSelected ? AppColors.primary : AppColors.black,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      fontSize: 11.rsp,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  // Step 6: Skills & Experience / Certificate Info (Matching uploaded Figma screenshot)
  Widget step6SkillsExperience(WorkerRegistrationController controller) {
    return Column(
      children: [
        skillCategoryGrid(controller),
        sizedboxHeight(16),
        sectionCard(
          title: "Experience Details",
          children: [
            inputLabelField(
              label: "Years of Experience",
              hintText: "Enter",
              controller: controller.experienceYearsController,
              keyboardType: TextInputType.number,
            ),
            sizedboxHeight(14),
            inputLabelField(
              label: "Previous Company",
              hintText: "Enter",
              controller: controller.previousCompanyController,
            ),
            sizedboxHeight(14),
            inputLabelField(
              label: "Daily Wage Expectation",
              hintText: "Enter",
              controller: controller.dailyWageController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        sizedboxHeight(16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.rw),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.rr),
            border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Skill Certificate Upload",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.ts16w600color000000().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  sizedboxWidth(6),
                  Text(
                    "Required",
                    style: AppTextStyles.ts12w500color808080().copyWith(
                      color: Colors.redAccent,
                      fontSize: 11.rsp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              sizedboxHeight(12),
              Obx(
                () => uploadFileField(
                  label: "ITI",
                  fileName: controller.itiCertPath.value,
                  onUpload: () => controller.pickImageOrDocument(controller.itiCertPath),
                  onView: () => controller.showDocumentPreviewDialog(
                    title: "ITI Certificate",
                    fileName: controller.itiCertPath.value,
                    onReupload: () => controller.pickImageOrDocument(controller.itiCertPath),
                  ),
                ),
              ),
              sizedboxHeight(12),
              Obx(
                () => uploadFileField(
                  label: "NSDC",
                  fileName: controller.nsdcCertPath.value,
                  onUpload: () => controller.pickImageOrDocument(controller.nsdcCertPath),
                  onView: () => controller.showDocumentPreviewDialog(
                    title: "NSDC Certificate",
                    fileName: controller.nsdcCertPath.value,
                    onReupload: () => controller.pickImageOrDocument(controller.nsdcCertPath),
                  ),
                ),
              ),
              sizedboxHeight(12),
              Obx(
                () => uploadFileField(
                  label: "Government Certificate",
                  fileName: controller.govtCertPath.value,
                  onUpload: () => controller.pickImageOrDocument(controller.govtCertPath),
                  onView: () => controller.showDocumentPreviewDialog(
                    title: "Government Certificate",
                    fileName: controller.govtCertPath.value,
                    onReupload: () => controller.pickImageOrDocument(controller.govtCertPath),
                  ),
                ),
              ),
              sizedboxHeight(12),
              Obx(
                () => uploadFileField(
                  label: "Other Certificates",
                  fileName: controller.otherCertPath.value,
                  onUpload: () => controller.pickImageOrDocument(controller.otherCertPath),
                  onView: () => controller.showDocumentPreviewDialog(
                    title: "Other Certificate",
                    fileName: controller.otherCertPath.value,
                    onReupload: () => controller.pickImageOrDocument(controller.otherCertPath),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 7: Availability (Matching Image 1)
}

