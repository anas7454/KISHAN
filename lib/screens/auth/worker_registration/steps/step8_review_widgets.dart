part of '../worker_registration_widgets.dart';

mixin Step8ReviewWidgets on WorkerRegistrationWidgets {
  String _reviewValue(String value, {String fallback = 'Not provided'}) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? fallback : trimmed;
  }

  String _reviewFile(String path) {
    final String trimmed = path.trim();
    const placeholders = <String>{'proof.pdf', 'front.pdf', 'certificate.pdf'};
    if (trimmed.isEmpty || placeholders.contains(trimmed)) {
      return 'Not uploaded';
    }
    final List<String> segments = Uri.tryParse(trimmed)?.pathSegments ?? [];
    return segments.isEmpty ? trimmed : segments.last;
  }

  bool _hasReviewFile(String path) => _reviewFile(path) != 'Not uploaded';

  Widget _reviewImage({
    required String label,
    required String path,
    required WorkerRegistrationController controller,
  }) {
    if (!_hasReviewFile(path)) {
      return _reviewDetail(label, 'Not uploaded');
    }

    final bool isNetwork =
        path.startsWith('http://') || path.startsWith('https://');
    final Widget image = isNetwork
        ? Image.network(
            path,
            width: double.infinity,
            height: 150.rh,
            fit: BoxFit.cover,
            cacheWidth: 720,
            cacheHeight: 360,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : _reviewImageLoading(),
            errorBuilder: (_, _, _) => _reviewImageError(),
          )
        : Image.file(
            File(path),
            width: double.infinity,
            height: 150.rh,
            fit: BoxFit.cover,
            cacheWidth: 720,
            cacheHeight: 360,
            errorBuilder: (_, _, _) => _reviewImageError(),
          );

    return Padding(
      padding: EdgeInsets.only(bottom: 12.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.ts12w500colorBlack()),
          sizedboxHeight(6),
          GestureDetector(
            onTap: () => controller.showDocumentPreviewDialog(
              title: label,
              fileName: path,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.rr),
              child: image,
            ),
          ),
          sizedboxHeight(4),
          Text(
            'Tap to view full image',
            style: AppTextStyles.ts12w500color808080(),
          ),
        ],
      ),
    );
  }

  Widget _reviewImageError() {
    return Container(
      width: double.infinity,
      height: 150.rh,
      color: AppColors.scafoldBg,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.color7D7D7D,
        size: 36.rsp,
      ),
    );
  }

  Widget _reviewImageLoading() {
    return Container(
      width: double.infinity,
      height: 150.rh,
      color: AppColors.scafoldBg,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _reviewDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.rh),
      child: Text('$label: $value', style: AppTextStyles.ts12w500colorBlack()),
    );
  }

  Widget reviewSectionCard({
    required String title,
    required int sectionIndex,
    required int editStep,
    required WorkerRegistrationController controller,
    required Widget summaryContent,
  }) {
    return Obx(() {
      final bool isExpanded = controller.expandedSections.toList().contains(
        sectionIndex,
      );

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.rh),
        padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
          border: Border.all(
            color: AppColors.borderDBDBDB,
            width: 1.rsp,
          ), // 1px #DBDBDB
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
                if (!controller.isPreviewMode.value)
                  InkWell(
                    onTap: () =>
                        controller.goToStep(editStep, isFromReview: true),
                    borderRadius: BorderRadius.circular(18.rr),
                    child: Container(
                      width: 36.rw,
                      height: 36.rh,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFF7D6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: AppColors.primary,
                        size: 18.rsp,
                      ),
                    ),
                  ),
                sizedboxWidth(4),
                InkWell(
                  onTap: () => controller.toggleSectionExpanded(sectionIndex),
                  borderRadius: BorderRadius.circular(22.rr),
                  child: SizedBox(
                    width: 44.rw,
                    height: 44.rh,
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.black,
                      size: 24.rsp,
                    ),
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
          editStep: 1,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewDetail(
                'Name',
                _reviewValue(controller.fullNameController.text),
              ),
              _reviewDetail('DOB', _reviewValue(controller.dobController.text)),
              _reviewDetail(
                'Gender',
                _reviewValue(controller.selectedGender.value),
              ),
              _reviewDetail(
                'Language',
                _reviewValue(
                  controller.languageController.text,
                  fallback: 'Not selected',
                ),
              ),
              _reviewDetail(
                'State',
                _reviewValue(controller.stateController.text),
              ),
              _reviewDetail(
                'City',
                _reviewValue(controller.cityController.text),
              ),
              _reviewDetail(
                'Pincode',
                _reviewValue(controller.pincodeController.text),
              ),
              _reviewDetail(
                'House/Plot No.',
                _reviewValue(controller.houseNoController.text),
              ),
              _reviewDetail(
                'Full Address',
                _reviewValue(controller.fullAddressController.text),
              ),
              _reviewImage(
                label: 'Address Proof',
                path: controller.addressProofPath.value,
                controller: controller,
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Bank Info",
          sectionIndex: 2,
          editStep: 2,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewDetail(
                'Account Holder',
                _reviewValue(controller.accountHolderNameController.text),
              ),
              _reviewDetail(
                'Account Number',
                _reviewValue(controller.accountNumberController.text),
              ),
              _reviewDetail(
                'IFSC Code',
                _reviewValue(controller.ifscCodeController.text),
              ),
              _reviewDetail(
                'Branch Name',
                _reviewValue(controller.branchNameController.text),
              ),
              _reviewImage(
                label: 'Passbook/Cheque',
                path: controller.passbookProofPath.value,
                controller: controller,
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Document's Uploaded",
          sectionIndex: 3,
          editStep: 3,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewImage(
                label: 'Aadhaar Front',
                path: controller.idFrontPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'Aadhaar Back',
                path: controller.idBackPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'PAN Card',
                path: controller.panCardPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'Police Certificate',
                path: controller.policeCertPath.value,
                controller: controller,
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Selfie Verification",
          sectionIndex: 4,
          editStep: 4,
          controller: controller,
          summaryContent: _reviewImage(
            label: 'Live Selfie',
            path: controller.liveSelfiePath.value,
            controller: controller,
          ),
        ),
        reviewSectionCard(
          title: "Skills & Experience / Certificate Info",
          sectionIndex: 5,
          editStep: 6,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewDetail(
                'Category',
                _reviewValue(
                  controller.selectedSkillCategory.value,
                  fallback: 'Not selected',
                ),
              ),
              _reviewDetail(
                'Services',
                _reviewValue(
                  controller.selectedServicesController.text,
                  fallback: 'Not selected',
                ),
              ),
              _reviewDetail(
                'Experience (Years)',
                _reviewValue(controller.experienceYearsController.text),
              ),
              _reviewDetail(
                'Work Description',
                _reviewValue(controller.workDescriptionController.text),
              ),
              _reviewDetail(
                'Previous Company',
                _reviewValue(controller.previousCompanyController.text),
              ),
              _reviewDetail(
                'Daily Wage Expectation',
                _reviewValue(controller.dailyWageController.text),
              ),
              _reviewImage(
                label: 'ITI Certificate',
                path: controller.itiCertPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'NSDC Certificate',
                path: controller.nsdcCertPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'Government Certificate',
                path: controller.govtCertPath.value,
                controller: controller,
              ),
              _reviewImage(
                label: 'Other Certificate',
                path: controller.otherCertPath.value,
                controller: controller,
              ),
            ],
          ),
        ),
        reviewSectionCard(
          title: "Availability",
          sectionIndex: 6,
          editStep: 7,
          controller: controller,
          summaryContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reviewDetail(
                'Work Type',
                _reviewValue(
                  controller.workTypeController.text,
                  fallback: 'Not selected',
                ),
              ),
              _reviewDetail(
                'Immediate Joining',
                _reviewValue(
                  controller.immediateJoiningController.text,
                  fallback: 'Not selected',
                ),
              ),
              _reviewDetail(
                'Working Radius',
                _reviewValue(controller.workingRadiusController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 9: Registration Complete Illustration (Figma Specs: 133.89 x 133.89px)
}
