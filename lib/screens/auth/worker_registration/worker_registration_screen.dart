import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_controller.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int step = controller.currentStep.value;
      final bool isContinueEnabled = step != 4 || controller.liveSelfiePath.value.isNotEmpty;

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          backgroundColor: AppColors.scafoldBg,
          appBar: stepHeader(
            title: _getStepTitle(step),
            currentStep: step,
            onBack: controller.previousStep,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                    physics: const ClampingScrollPhysics(),
                    child: _buildStepBody(context, step),
                  ),
                ),
                stepBottomButtons(
                  onContinue: controller.nextStep,
                  onSaveDraft: controller.saveAsDraft,
                  isContinueEnabled: isContinueEnabled,
                  continueButtonText: _getContinueButtonText(step),
                  showSaveDraft: step != 9,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
