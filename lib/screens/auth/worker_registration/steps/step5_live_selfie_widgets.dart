part of '../worker_registration_widgets.dart';

mixin Step5LiveSelfieWidgets on Step4LiveSelfieWidgets {
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
}

