import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb3HomeScreen extends StatelessWidget with Bnb3HomeWidgets {
  Bnb3HomeScreen({super.key});

  final Bnb3HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.refreshLocation,
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Top Location Bar Header
              workerHomeHeader(context, controller),
              sizedboxHeight(14),
              // Body Padding Container
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                child: Obx(() {
                  final bool isUnderReview = controller.isUnderReview.value;
                  return Column(
                    children: [
                      // 1. Worker Profile Header Card
                      workerProfileCard(controller),
                      if (isUnderReview) ...[
                        sizedboxHeight(12),
                        workerStatusActionCard(controller),
                        sizedboxHeight(12),
                        verificationStepsList(),
                      ] else ...[
                        sizedboxHeight(12),
                        workerKeyStatsGrid(),
                        sizedboxHeight(12),
                        ongoingProjectCard(),
                        sizedboxHeight(16),
                        newRequestsSection(),
                      ],
                      sizedboxHeight(20),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
