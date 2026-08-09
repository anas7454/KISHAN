part of '../worker_registration_widgets.dart';

mixin Step1PersonalInfoWidgets on WorkerRegistrationWidgets {
  Widget step1PersonalInfo(BuildContext context, WorkerRegistrationController controller) {
    return Column(
      children: [
        sectionCard(
          title: "Basic Info",
          children: [
            inputLabelField(
              label: "Full Name",
              hintText: "Enter",
              controller: controller.fullNameController,
            ),
            sizedboxHeight(14),
            inputLabelField(
              label: "Date of Birth",
              hintText: "Select Date",
              controller: controller.dobController,
              readOnly: true,
              onTap: () => controller.pickDateOfBirth(context),
              suffixIcon: Icon(
                Icons.calendar_month_rounded,
                color: AppColors.color7D7D7D,
                size: 20.rsp,
              ),
            ),
            sizedboxHeight(14),
            genderRadioSelector(controller),
            sizedboxHeight(14),
            inputLabelField(
              label: "Language",
              hintText: "Select",
              controller: controller.languageController,
              readOnly: true,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.color7D7D7D,
                size: 22.rsp,
              ),
              onTap: controller.openLanguageBottomSheet,
            ),
          ],
        ),
        sizedboxHeight(16),
        sectionCard(
          title: "Current Address Verification",
          children: [
            // 1. State & 2. City
            Row(
              children: [
                Expanded(
                  child: inputLabelField(
                    label: "State",
                    hintText: "Select",
                    controller: controller.stateController,
                    readOnly: true,
                    onTap: controller.openStateBottomSheet,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.color7D7D7D,
                      size: 20.rsp,
                    ),
                  ),
                ),
                sizedboxWidth(10),
                Expanded(
                  child: inputLabelField(
                    label: "City",
                    hintText: "Select",
                    controller: controller.cityController,
                    readOnly: true,
                    onTap: controller.openCityBottomSheet,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.color7D7D7D,
                      size: 20.rsp,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(14),
            // 3. Pincode & 4. House/Plot No.
            Row(
              children: [
                Expanded(
                  child: inputLabelField(
                    label: "Pincode",
                    hintText: "Enter",
                    controller: controller.pincodeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                sizedboxWidth(10),
                Expanded(
                  child: inputLabelField(
                    label: "House/Plot No.",
                    hintText: "Enter",
                    controller: controller.houseNoController,
                  ),
                ),
              ],
            ),
            sizedboxHeight(14),
            // 5. Full Address
            inputLabelField(
              label: "Full Address",
              hintText: "Enter",
              controller: controller.fullAddressController,
            ),
            sizedboxHeight(14),
            // 6. Address Proof Upload
            Obx(
              () => uploadFileField(
                label: "Address Proof Upload",
                fileName: controller.addressProofPath.value,
                defaultPlaceholder: "proof.pdf",
                onUpload: () => controller.pickImageOrDocument(controller.addressProofPath),
                onView: () => controller.showDocumentPreviewDialog(
                  title: "Address Proof Document",
                  fileName: controller.addressProofPath.value,
                  onReupload: () => controller.pickImageOrDocument(controller.addressProofPath),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Step 2: Bank Info
}

