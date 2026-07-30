import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_controller.dart';
import 'package:constructo_worker/utils/buttons/back_button_custom.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/theme/widgets/divider_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin WorkerRegistrationWidgets {
  // Common Step App Bar
  PreferredSizeWidget stepHeader({
    required String title,
    required int currentStep,
    required VoidCallback onBack,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(66.rh),
      child: AppBar(
        toolbarHeight: 66.rh,
        backgroundColor: AppColors.yellowBg,
        surfaceTintColor: AppColors.yellowBg,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 44.rw,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.rw),
          child: Center(
            child: BackButtonCustom(
              onTap: onBack,
            ),
          ),
        ),
        titleSpacing: 4.rw,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts18w700color000000().copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            sizedboxHeight(2),
            Text(
              "Step $currentStep of 8",
              style: AppTextStyles.ts12w500color808080(),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.rsp),
          child: Container(
            height: 1.rsp,
            color: AppColors.homeCardBorder, // #FFEF9E 1px bottom border
          ),
        ),
      ),
    );
  }

  // Common Bottom Action Buttons (Figma Specs: Frame 34636 & 34638, Height: 40px, Radius: 100px, Gap: 8px, SaveDraft: #FFCC00 10%)
  Widget stepBottomButtons({
    required VoidCallback onContinue,
    required VoidCallback onSaveDraft,
    bool isContinueEnabled = true,
    String continueButtonText = "Continue",
    bool showSaveDraft = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: Offset(0, -13.rh),
            blurRadius: 17.rr,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            name: continueButtonText,
            onPressed: isContinueEnabled ? onContinue : () {},
            btnColor: isContinueEnabled ? AppColors.black : const Color(0xff8D8D8D),
            textColor: AppColors.white,
            height: 40.rh,
            borderRadiusDouble: 100.rh,
            fontWeight: FontWeight.w600,
            fontsize: 14.rsp,
          ),
          if (showSaveDraft) ...[
            sizedboxHeight(8),
            Button(
              name: "Save as Draft",
              onPressed: onSaveDraft,
              btnColor: AppColors.primary.withValues(alpha: 0.10), // #FFCC00 10%
              textColor: AppColors.black,
              height: 40.rh,
              borderRadiusDouble: 100.rh,
              fontWeight: FontWeight.w600,
              fontsize: 14.rsp,
              elevation: 0,
            ),
          ],
        ],
      ),
    );
  }

  // Common White Section Card Container (Figma Frame Specs: 8px radius, 1px #DBDBDB border, 12px padding, 12px gap)
  Widget sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
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
          Text(
            title,
            style: AppTextStyles.ts16w600color000000().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          sizedboxHeight(12),
          ...children,
        ],
      ),
    );
  }

  // Reusable Input Field with Label (Figma Specs: Height: 44px, Radius: 10px, Border: 1px #D7D7D7, Padding: 9px 10px, Gap: 7px, LinearGradient background)
  Widget inputLabelField({
    required String label,
    required String hintText,
    TextEditingController? controller,
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
                  color: const Color(0x2EFFFFFF), // #FFFFFF 18% opacity
                  offset: Offset(0, 3.rh),
                  blurRadius: 4.rr,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(color: AppColors.borderTextfiled, width: 1.rsp), // #D7D7D7
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

  // Reusable File Upload Field (Figma Specs: Group 8857, Width: 81px, Height: 29px, Fill: 0%, Border: 1px #FFBC07 40%)
  Widget uploadFileField({
    required String label,
    required String fileName,
    VoidCallback? onUpload,
    VoidCallback? onView,
    String defaultPlaceholder = 'proof.pdf',
  }) {
    final bool isUploaded = fileName.isNotEmpty &&
        fileName != 'proof.pdf' &&
        fileName != 'front.pdf' &&
        fileName != 'certificate.pdf';

    final String shortFileName = isUploaded
        ? fileName.split('/').last.split('\\').last
        : defaultPlaceholder;

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
          onTap: isUploaded ? null : onUpload,
          child: Container(
            height: 44.rh,
            width: double.infinity,
            padding: EdgeInsets.only(left: 10.rw, right: 8.rw),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(51, 51, 51, 0.03),
                  Color.fromRGBO(0, 0, 0, 0.03),
                ],
              ),
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(
                color: isUploaded ? AppColors.primary : AppColors.borderTextfiled,
                width: 1.rsp,
              ),
            ),
            child: Row(
              children: [
                if (isUploaded) ...[
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 18.rsp,
                  ),
                  sizedboxWidth(6),
                ],
                Expanded(
                  child: Text(
                    shortFileName,
                    style: AppTextStyles.ts14w500color7D7D7D().copyWith(
                      color: isUploaded ? AppColors.black : AppColors.color7D7D7D,
                      fontWeight: isUploaded ? FontWeight.w600 : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                sizedboxWidth(8),
                if (!isUploaded)
                  InkWell(
                    onTap: onUpload,
                    borderRadius: BorderRadius.circular(15.rr),
                    child: Container(
                      width: 81.rw,
                      height: 29.rh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.rr),
                        border: Border.all(
                          color: AppColors.colorFFBC07.withValues(alpha: 0.40),
                          width: 1.rsp,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 14.rsp,
                            color: AppColors.colorFFBC07,
                          ),
                          sizedboxWidth(4),
                          Text(
                            "Upload",
                            style: AppTextStyles.ts12w600color000000().copyWith(
                              color: AppColors.colorFFBC07,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.rsp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: onView,
                    borderRadius: BorderRadius.circular(15.rr),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.rr),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: 15.rsp,
                            color: AppColors.black,
                          ),
                          sizedboxWidth(4),
                          Text(
                            "View",
                            style: AppTextStyles.ts12w600color000000().copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.rsp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Reusable Gender Radio Selector (Figma Specs: Frame 2147227007, Radius: 4px, Height: 32px, Border: 1px #D7D7D7, Padding: 6px 8px, Gap: 2px)
  Widget genderRadioSelector(WorkerRegistrationController controller) {
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
        sizedboxHeight(6),
        Obx(() {
          return Row(
            children: genders.map((gender) {
              final bool isSelected = controller.selectedGender.value == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.setGender(gender),
                  child: Container(
                    height: 32.rh,
                    margin: EdgeInsets.only(right: gender != 'Other' ? 8.rw : 0),
                    padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 6.rh),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.rr),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.borderTextfiled, // #D7D7D7
                        width: 1.rsp,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 14.rw,
                          height: 14.rw,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.colorBFBFBF,
                              width: 1.2.rsp,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 9.rsp,
                                    color: AppColors.primary,
                                  ),
                                )
                              : null,
                        ),
                        sizedboxWidth(2), // 2px gap per Figma specs
                        Text(
                          gender,
                          style: AppTextStyles.ts12w500colorBlack().copyWith(
                            color: isSelected ? AppColors.primary : AppColors.black,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  // Step 1: Personal Info
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
  Widget step2BankInfo(WorkerRegistrationController controller) {
    return sectionCard(
      title: "Bank Details",
      children: [
        inputLabelField(
          label: "Account Holder Name",
          hintText: "Enter",
          controller: controller.accountHolderNameController,
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Account Number",
          hintText: "Enter (9-18 digits)",
          controller: controller.accountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 18,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Confirm Account Number",
          hintText: "Re-enter Account Number",
          controller: controller.confirmAccountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 18,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "IFSC Code",
          hintText: "e.g. SBIN0001234",
          controller: controller.ifscCodeController,
          textCapitalization: TextCapitalization.characters,
          maxLength: 11,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
          ],
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Branch Name",
          hintText: "Enter",
          controller: controller.branchNameController,
        ),
        sizedboxHeight(14),
        Obx(
          () => uploadFileField(
            label: "Passbook/Cancelled Cheque (Optional)",
            fileName: controller.passbookProofPath.value,
            onUpload: () => controller.pickImageOrDocument(controller.passbookProofPath),
            onView: () => controller.showDocumentPreviewDialog(
              title: "Passbook / Cheque Proof",
              fileName: controller.passbookProofPath.value,
              onReupload: () => controller.pickImageOrDocument(controller.passbookProofPath),
            ),
          ),
        ),
      ],
    );
  }

  // Step 3: Document's Upload
  Widget step3DocumentsUpload(WorkerRegistrationController controller) {
    return Column(
      children: [
        sectionCard(
          title: "Identity Verification",
          children: [
            Obx(
              () => uploadFileField(
                label: "Aadhar Front",
                fileName: controller.idFrontPath.value,
                onUpload: () => controller.pickImageOrDocument(controller.idFrontPath),
                onView: () => controller.showDocumentPreviewDialog(
                  title: "Aadhar Front",
                  fileName: controller.idFrontPath.value,
                  onReupload: () => controller.pickImageOrDocument(controller.idFrontPath),
                ),
              ),
            ),
            sizedboxHeight(14),
            Obx(
              () => uploadFileField(
                label: "Aadhar Back",
                fileName: controller.idBackPath.value,
                onUpload: () => controller.pickImageOrDocument(controller.idBackPath),
                onView: () => controller.showDocumentPreviewDialog(
                  title: "Aadhar Back",
                  fileName: controller.idBackPath.value,
                  onReupload: () => controller.pickImageOrDocument(controller.idBackPath),
                ),
              ),
            ),
            sizedboxHeight(14),
            Obx(
              () => uploadFileField(
                label: "PAN Card",
                fileName: controller.panCardPath.value,
                onUpload: () => controller.pickImageOrDocument(controller.panCardPath),
                onView: () => controller.showDocumentPreviewDialog(
                  title: "PAN Card Document",
                  fileName: controller.panCardPath.value,
                  onReupload: () => controller.pickImageOrDocument(controller.panCardPath),
                ),
              ),
            ),
          ],
        ),
        sizedboxHeight(16),
        sectionCard(
          title: "Police Verification",
          children: [
            Obx(
              () => uploadFileField(
                label: "Upload Certificate",
                fileName: controller.policeCertPath.value,
                onUpload: () => controller.pickImageOrDocument(controller.policeCertPath),
                onView: () => controller.showDocumentPreviewDialog(
                  title: "Police Certificate",
                  fileName: controller.policeCertPath.value,
                  onReupload: () => controller.pickImageOrDocument(controller.policeCertPath),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Common Face Verification Card Widget (Step 4 & Step 5 - Figma Specs: Frame 2147227006, Height: 365px, Radius: 8px, Border: 1px #DBDBDB)
  Widget liveSelfieVerificationCard({
    required bool isCaptured,
    required WorkerRegistrationController controller,
  }) {
    return sectionCard(
      title: "Face Verification",
      children: [
        sizedboxHeight(8),
        Center(
          child: SizedBox(
            width: 240.rw,
            height: 240.rh,
            child: CustomPaint(
              painter: CornerBracketsPainter(
                color: isCaptured ? const Color(0xff2E7D32) : AppColors.black,
                bracketLength: 36.rw,
                strokeWidth: 2.rsp,
              ),
              child: Center(
                child: SizedBox(
                  width: 200.rw,
                  height: 200.rh,
                  child: Obx(() {
                    final String path = controller.liveSelfiePath.value;
                    final bool hasFile = isCaptured || path.isNotEmpty;

                    return hasFile
                        ? CustomPaint(
                            painter: DottedCircleBorderPainter(
                              color: const Color(0xff2E7D32),
                              strokeWidth: 3.rsp,
                              dotRadius: 2.5.rsp,
                              spacing: 5.rw,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.rw),
                              child: ClipOval(
                                child: path.isNotEmpty && File(path).existsSync()
                                    ? Image.file(
                                        File(path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: AppColors.colorE8E8E8,
                                          child: Icon(Icons.person_rounded,
                                              size: 80.rsp, color: AppColors.black),
                                        ),
                                      ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffD9D9D9),
                              shape: BoxShape.circle,
                            ),
                          );
                  }),
                ),
              ),
            ),
          ),
        ),
        sizedboxHeight(14),
        Obx(() {
          final String path = controller.liveSelfiePath.value;
          final bool isLiveCaptured = isCaptured || path.isNotEmpty;
          return isLiveCaptured
              ? Button(
                  name: "Remove",
                  onPressed: controller.removeLiveSelfie,
                  btnColor: const Color(0xff8D8D8D),
                  textColor: AppColors.white,
                  height: 40.rh,
                  borderRadiusDouble: 100.rh,
                  fontWeight: FontWeight.w600,
                  fontsize: 14.rsp,
                  elevation: 0,
                )
              : Button(
                  name: "Capture Live Photo",
                  onPressed: controller.captureLiveSelfie,
                  btnColor: AppColors.black,
                  textColor: AppColors.white,
                  height: 40.rh,
                  borderRadiusDouble: 100.rh,
                  fontWeight: FontWeight.w600,
                  fontsize: 14.rsp,
                );
        }),
      ],
    );
  }

  // 4 Instruction Guidelines Row (Figma Specs: 30x30px container, 2px radius, #E0E0E0 fill, dotted dividers - Fixed overflow)
  Widget selfieInstructionGuidelines() {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.center_focus_weak_rounded,
        'title': 'Look at\nthe camera',
      },
      {
        'icon': Icons.wb_sunny_outlined,
        'title': 'Use good\nlighting',
      },
      {
        'icon': Icons.block_rounded,
        'title': 'No hat or\nsunglasses',
      },
      {
        'icon': Icons.account_circle_outlined,
        'title': 'Keep your\nface inside\nthe frame',
      },
    ];

    List<Widget> rowChildren = [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      rowChildren.add(
        Expanded(
          child: Column(
            children: [
              Container(
                width: 30.rw,
                height: 30.rh,
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0), // #E0E0E0 Figma spec
                  borderRadius: BorderRadius.circular(2.rr), // 2px radius
                ),
                child: Icon(
                  item['icon'] as IconData,
                  size: 16.rsp,
                  color: AppColors.black,
                ),
              ),
              sizedboxHeight(8),
              Text(
                item['title'] as String,
                textAlign: TextAlign.center,
                style: AppTextStyles.ts12w500colorBlack().copyWith(
                  fontSize: 10.5.rsp,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );

      if (i < items.length - 1) {
        rowChildren.add(
          SizedBox(
            height: 44.rh,
            width: 1.rw,
            child: CustomPaint(
              painter: DottedVerticalDividerPainter(
                color: const Color(0xffE0E0E0),
                strokeWidth: 1.rsp,
                dashLength: 2.rh,
                dashGap: 3.rh,
              ),
            ),
          ),
        );
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }

  // Step 4: Live Selfie Verification (Uncaptured)
  Widget step4LiveSelfie(WorkerRegistrationController controller) {
    return Column(
      children: [
        liveSelfieVerificationCard(isCaptured: false, controller: controller),
        sizedboxHeight(24),
        selfieInstructionGuidelines(),
      ],
    );
  }

  // Step 5: Live Selfie Verification (Captured)
  Widget step5LiveSelfie(WorkerRegistrationController controller) {
    return Column(
      children: [
        liveSelfieVerificationCard(isCaptured: true, controller: controller),
        sizedboxHeight(24),
        selfieInstructionGuidelines(),
      ],
    );
  }

  // 8 Skill Category Cards Grid (Figma Specs: Frame 2147227015 & 2147227016, 81x81px, Radius: 10px, Gap: 7px, Selected: #FFCC00, Unselected: #D0D0D0)
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
  Widget step7Availability(WorkerRegistrationController controller) {
    return sectionCard(
      title: "Availability",
      children: [
        inputLabelField(
          label: "Full Time / Part Time",
          hintText: "Select",
          controller: controller.workTypeController,
          readOnly: true,
          onTap: controller.openWorkTypeBottomSheet,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.color7D7D7D,
            size: 22.rsp,
          ),
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Immediate Joining",
          hintText: "Select",
          controller: controller.immediateJoiningController,
          readOnly: true,
          onTap: controller.openImmediateJoiningBottomSheet,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.color7D7D7D,
            size: 22.rsp,
          ),
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Preferred Working Radius",
          hintText: "10 km",
          controller: controller.workingRadiusController,
          readOnly: true,
          onTap: controller.openWorkingRadiusBottomSheet,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.color7D7D7D,
            size: 22.rsp,
          ),
        ),
      ],
    );
  }

  // Common Review Section Card Widget with Edit Button & Expandable Content
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
  Widget registrationSuccessIllustration() {
    return SizedBox(
      width: 170.rw,
      height: 150.rh,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Outer soft green circle ring 1 (134x134px Figma spec)
          Container(
            width: 134.rw,
            height: 134.rh,
            decoration: const BoxDecoration(
              color: Color(0xffEBF7EE), // #EBF7EE soft green Figma spec
              shape: BoxShape.circle,
            ),
          ),
          // Inner soft green circle ring 2 (94x94px Figma spec)
          Container(
            width: 94.rw,
            height: 94.rh,
            decoration: const BoxDecoration(
              color: Color(0xffD5EFDC), // #D5EFDC medium green Figma spec
              shape: BoxShape.circle,
            ),
          ),
          // Solid green center circle with white check icon (56x56px Figma spec)
          Container(
            width: 56.rw,
            height: 56.rh,
            decoration: const BoxDecoration(
              color: Color(0xff2EAD42), // #2EAD42 green Figma spec
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.white,
              size: 32.rsp,
            ),
          ),
          // Floating green sparkles around illustration
          Positioned(
            top: 4.rh,
            left: 28.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 10.rsp),
          ),
          Positioned(
            top: 2.rh,
            right: 42.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 8.rsp),
          ),
          Positioned(
            top: 32.rh,
            right: 8.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 16.rsp),
          ),
          Positioned(
            bottom: 28.rh,
            left: 8.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 14.rsp),
          ),
          Positioned(
            bottom: 8.rh,
            right: 32.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 10.rsp),
          ),
        ],
      ),
    );
  }

  Widget registrationInfoCard({
    required String title,
    required String subtitlePrefix,
    required String highlightText,
    required String subtitleSuffix,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.rh),
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh), // Top/Bottom: 12px, Left/Right: 16px Figma spec
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.ts14w600colorBlack().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          sizedboxHeight(6), // 6px gap Figma spec
          RichText(
            text: TextSpan(
              style: AppTextStyles.ts12w500color808080().copyWith(
                color: AppColors.color7D7D7D,
                fontSize: 12.rsp,
                height: 1.3,
              ),
              children: [
                TextSpan(text: subtitlePrefix),
                if (highlightText.isNotEmpty)
                  TextSpan(
                    text: highlightText,
                    style: const TextStyle(
                      color: Color(0xff16A34A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (subtitleSuffix.isNotEmpty) TextSpan(text: subtitleSuffix),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget step9RegistrationComplete(WorkerRegistrationController controller) {
    return Column(
      children: [
        sizedboxHeight(8),
        Center(child: registrationSuccessIllustration()),
        sizedboxHeight(12),
        Text(
          "Registration Successful!",
          textAlign: TextAlign.center,
          style: AppTextStyles.ts18w700color000000().copyWith(
            fontSize: 20.rsp,
            fontWeight: FontWeight.w800,
          ),
        ),
        sizedboxHeight(8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.rw),
          child: Text(
            "Congratulations! Your application has been submitted successfully. We will review your information and get back to you soon.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts12w500color808080().copyWith(
              color: AppColors.color7D7D7D,
              fontSize: 12.rsp,
              height: 1.4,
            ),
          ),
        ),
        sizedboxHeight(20),
        // Your Application ID Card (Figma Specs: Frame 2147227006, 360x60px Hug, Radius: 8px, Gap: 6px)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
            border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp), // 1px #DBDBDB
          ),
          child: Row(
            children: [
              Container(
                width: 36.rw,
                height: 36.rh,
                decoration: BoxDecoration(
                  color: const Color(0xff16A34A).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.rr),
                ),
                child: Icon(
                  Icons.badge_outlined,
                  color: const Color(0xff16A34A),
                  size: 20.rsp,
                ),
              ),
              sizedboxWidth(6), // 6px gap Figma spec
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Application ID",
                    style: AppTextStyles.ts12w500color808080().copyWith(
                      fontSize: 11.rsp,
                      height: 1.2,
                    ),
                  ),
                  sizedboxHeight(2),
                  Text(
                    "APP2026072200001",
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      color: const Color(0xff16A34A),
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5.rsp,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        sizedboxHeight(16),
        // 4 Status Timeline Cards
        registrationInfoCard(
          title: "Application Review",
          subtitlePrefix: "Our team will review your application within ",
          highlightText: "2 - 3 working days.",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Verification & Communication",
          subtitlePrefix: "We may contact you for any additional information if required.",
          highlightText: "",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Application Status Update",
          subtitlePrefix: "You will receive updates on your application status via ",
          highlightText: "SMS and Email",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Approval & Onboarding",
          subtitlePrefix: "Once approved, you can start your journey with us!",
          highlightText: "",
          subtitleSuffix: "",
        ),
        sizedboxHeight(4),
        // Need Help Card (Figma Specs: Profile Container, 360x64px Hug, Radius: 8px, #F6FAFE fill, #EEEEEE border)
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.rh, bottom: 12.rh, left: 16.rw, right: 21.rw), // Figma padding: Top 12, Right 21.18, Bottom 12, Left 15.88
          decoration: BoxDecoration(
            color: const Color(0xffF6FAFE), // #F6FAFE fill Figma spec
            borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
            border: Border.all(color: const Color(0xffEEEEEE), width: 1.rsp), // 1.06px #EEEEEE border Figma spec
          ),
          child: Row(
            children: [
              Container(
                width: 38.rw,
                height: 38.rh,
                decoration: const BoxDecoration(
                  color: Color(0xffD9E8FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.headset_mic_rounded,
                  color: const Color(0xff1E88E5),
                  size: 20.rsp,
                ),
              ),
              sizedboxWidth(8), // 8.47px gap Figma spec
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Need Help?",
                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5.rsp,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Our support team is here to help you.",
                      style: AppTextStyles.ts12w500color808080().copyWith(
                        fontSize: 11.5.rsp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.black,
                size: 20.rsp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Corner Brackets around Face Frame
class CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double bracketLength;
  final double strokeWidth;

  CornerBracketsPainter({
    required this.color,
    this.bracketLength = 36.0,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double l = bracketLength;

    // Top-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, l)
        ..lineTo(0, 0)
        ..lineTo(l, 0),
      paint,
    );

    // Top-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - l, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, l),
      paint,
    );

    // Bottom-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - l)
        ..lineTo(0, size.height)
        ..lineTo(l, size.height),
      paint,
    );

    // Bottom-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - l, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - l),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for Green Dotted Circle Border (Step 5)
class DottedCircleBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dotRadius;
  final double spacing;

  DottedCircleBorderPainter({
    required this.color,
    this.strokeWidth = 3.0,
    this.dotRadius = 2.5,
    this.spacing = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth;
    final circumference = 2 * pi * radius;
    final totalDots = (circumference / (dotRadius * 2 + spacing)).floor();

    for (int i = 0; i < totalDots; i++) {
      final angle = (2 * pi / totalDots) * i;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for Dotted Vertical Dividers between guidelines
class DottedVerticalDividerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  DottedVerticalDividerPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashLength = 2.0,
    this.dashGap = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashLength),
        paint,
      );
      startY += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
