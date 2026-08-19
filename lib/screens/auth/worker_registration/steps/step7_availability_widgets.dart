part of '../worker_registration_widgets.dart';

mixin Step7AvailabilityWidgets on WorkerRegistrationWidgets {
  Widget step7Availability(WorkerRegistrationController controller) {
    return sectionCard(
      title: "Availability",
      children: [
        inputLabelField(
          label: "Full Time / Part Time",
          hintText: "Select work type",
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
          hintText: "Select joining availability",
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
          hintText: "Select working radius",
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
}
