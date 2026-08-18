import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_controller.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerRegistrationScreen extends StatelessWidget
    with
        WorkerRegistrationWidgets,
        Step1PersonalInfoWidgets,
        Step2BankInfoWidgets,
        Step3DocumentsUploadWidgets,
        Step4LiveSelfieWidgets,
        Step5LiveSelfieWidgets,
        Step6SkillsExperienceWidgets,
        Step7AvailabilityWidgets,
        Step8ReviewWidgets,
        Step9RegistrationCompleteWidgets {
  WorkerRegistrationScreen({super.key});

  final WorkerRegistrationController controller = Get.find();

  String _getStepTitle(int step) {
    switch (step) {
      case 1:
        return "Personal Info";
      case 2:
        return "Bank Info";
      case 3:
        return "Document's Upload";
      case 4:
      case 5:
        return "Live Selfie Verification";
      case 6:
        return "Skills & Experience / Certificate Info";
      case 7:
        return "Availability";
      case 8:
        return "Review All Details";
      case 9:
        return "Registration Complete";
      default:
        return "Worker Registration";
    }
  }

  Widget _buildStepBody(BuildContext context, int step) {
    switch (step) {
      case 1:
        return step1PersonalInfo(context, controller);
      case 2:
        return step2BankInfo(controller);
      case 3:
        return step3DocumentsUpload(controller);
      case 4:
        return step4LiveSelfie(controller);
      case 5:
        return step5LiveSelfie(controller);
      case 6:
        return step6SkillsExperience(controller);
      case 7:
        return step7Availability(controller);
      case 8:
        return step8ReviewAllDetails(controller);
      case 9:
        return step9RegistrationComplete(controller);
      default:
        return step1PersonalInfo(context, controller);
    }
  }

  String _getContinueButtonText(int step) {
    if (step == 7) {
      return "Review All Details";
    } else if (step == 8) {
      return "Submit Application";
    } else if (step == 9) {
      return "Go to dashboard";
    }
    return "Continue";
  }

  // ignore: unused_element
  Widget _buildKycProgress() {
    if (controller.isKycStatusLoading.value &&
        controller.kycProgressSections.isEmpty) {
      return const LinearProgressIndicator(color: AppColors.primary);
    }
    if (controller.kycStatusError.value.isNotEmpty &&
        controller.kycProgressSections.isEmpty) {
      return Container(
        margin: EdgeInsets.fromLTRB(16.rw, 12.rh, 16.rw, 0),
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: AppColors.borderDBDBDB),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.kycStatusError.value,
                style: AppTextStyles.ts12w500color808080(),
              ),
            ),
            TextButton(
              onPressed: controller.refreshKycProgress,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (controller.kycProgressSections.isEmpty) {
      if (!controller.hasLoadedKycStatus.value) {
        return const SizedBox.shrink();
      }
      return Container(
        margin: EdgeInsets.fromLTRB(16.rw, 12.rh, 16.rw, 0),
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: AppColors.borderDBDBDB),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded, color: AppColors.primary),
            sizedboxWidth(8),
            Expanded(
              child: Text(
                'KYC steps are not available yet.',
                style: AppTextStyles.ts12w500color808080(),
              ),
            ),
            TextButton(
              onPressed: controller.refreshKycProgress,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final int total = controller.totalKycSections.value == 0
        ? 8
        : controller.totalKycSections.value;
    final int completed = controller.completedKycSections.value;
    final double progress = (completed / total).clamp(0.0, 1.0);
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.rw, 10.rh, 16.rw, 10.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'KYC Progress',
                  style: AppTextStyles.ts14w600colorBlack(),
                ),
              ),
              Text(
                '$completed / $total completed',
                style: AppTextStyles.ts12w500color808080(),
              ),
            ],
          ),
          sizedboxHeight(7),
          LinearProgressIndicator(
            value: progress,
            color: AppColors.primary,
            backgroundColor: AppColors.borderE6E6E6,
            borderRadius: BorderRadius.circular(10.rr),
          ),
          sizedboxHeight(9),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.kycProgressSections.map((section) {
                final bool rejected = section.status == 'REJECTED';
                return Padding(
                  padding: EdgeInsets.only(right: 7.rw),
                  child: ActionChip(
                    onPressed: section.canOpen
                        ? () => controller.openKycProgressSection(section)
                        : null,
                    avatar: Icon(
                      section.isCompleted
                          ? Icons.check_circle_rounded
                          : section.canOpen
                          ? Icons.radio_button_unchecked_rounded
                          : Icons.lock_outline_rounded,
                      size: 16.rsp,
                      color: rejected
                          ? Colors.red
                          : section.isCompleted
                          ? Colors.green
                          : AppColors.color7D7D7D,
                    ),
                    label: Text(section.title),
                    tooltip: section.remark.isEmpty
                        ? section.status
                        : section.remark,
                  ),
                );
              }).toList(),
            ),
          ),
          if (controller.kycProgressSections.any(
            (section) => section.remark.isNotEmpty,
          )) ...[
            sizedboxHeight(6),
            Text(
              controller.kycProgressSections
                  .where((section) => section.remark.isNotEmpty)
                  .map((section) => '${section.title}: ${section.remark}')
                  .join('\n'),
              style: AppTextStyles.ts12w500color808080().copyWith(
                color: Colors.redAccent,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int step = controller.currentStep.value;
      final bool isContinueEnabled =
          step != 4 || controller.liveSelfiePath.value.isNotEmpty;

      return PopScope(
        canPop: controller.isPreviewMode.value,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.closeApp();
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Scaffold(
            backgroundColor: AppColors.scafoldBg,
            appBar: stepHeader(
              title: _getStepTitle(step),
              currentStep: step,
              onBack: controller.isPreviewMode.value
                  ? () => Get.back<void>()
                  : controller.closeApp,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.rw,
                        vertical: 16.rh,
                      ),
                      physics: const ClampingScrollPhysics(),
                      child:
                          controller.isPreviewMode.value &&
                              controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : _buildStepBody(context, step),
                    ),
                  ),
                  if (!controller.isPreviewMode.value)
                    stepBottomButtons(
                      onContinue: controller.nextStep,
                      onSaveDraft: controller.saveAsDraft,
                      isContinueEnabled: isContinueEnabled,
                      isLoading: controller.isLoading.value,
                      continueButtonText: _getContinueButtonText(step),
                      showSaveDraft: step != 9,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
