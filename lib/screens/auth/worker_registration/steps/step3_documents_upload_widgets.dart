part of '../worker_registration_widgets.dart';

mixin Step3DocumentsUploadWidgets on WorkerRegistrationWidgets {
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
}

