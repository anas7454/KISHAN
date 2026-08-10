import 'package:constructo_worker/screens/worker_verification_status/worker_verification_status_controller.dart';
import 'package:constructo_worker/screens/worker_verification_status/worker_verification_status_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerVerificationStatusScreen extends StatelessWidget with WorkerVerificationStatusWidgets {
  WorkerVerificationStatusScreen({super.key});

  final WorkerVerificationStatusController controller = Get.put(WorkerVerificationStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: Column(
        children: [
          // Fixed Top Location Header
          verificationHeader(context, controller),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: controller.refreshStatus,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    sizedboxHeight(14),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw),
                      child: Column(
                        children: [
                          // 1. Worker Profile Header Card
                          workerProfileCard(controller),
                          sizedboxHeight(12),
                          // 2. Verification Steps List
                          Obx(() => verificationStepsList(controller)),
                          sizedboxHeight(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
