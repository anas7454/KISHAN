part of '../worker_registration_widgets.dart';

mixin Step2BankInfoWidgets on WorkerRegistrationWidgets {
  Widget step2BankInfo(WorkerRegistrationController controller) {
    return sectionCard(
      title: "Bank Details",
      children: [
        inputLabelField(
          label: "Account Holder Name",
          hintText: "Enter account holder name",
          controller: controller.accountHolderNameController,
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Account Number",
          hintText: "Enter account number (9-18 digits)",
          controller: controller.accountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 18,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "Confirm Account Number",
          hintText: "Re-enter account number",
          controller: controller.confirmAccountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 18,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        sizedboxHeight(14),
        inputLabelField(
          label: "IFSC Code",
          hintText: "Enter IFSC code (e.g. SBIN0001234)",
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
          hintText: "Enter branch name",
          controller: controller.branchNameController,
        ),
        sizedboxHeight(14),
        Obx(
          () => uploadFileField(
            label: "Passbook/Cancelled Cheque (Optional)",
            fileName: controller.passbookProofPath.value,
            onUpload: () =>
                controller.pickImageOrDocument(controller.passbookProofPath),
            onView: () => controller.showDocumentPreviewDialog(
              title: "Passbook / Cheque Proof",
              fileName: controller.passbookProofPath.value,
              onReupload: () =>
                  controller.pickImageOrDocument(controller.passbookProofPath),
            ),
          ),
        ),
      ],
    );
  }

  // Step 3: Document's Upload
}
