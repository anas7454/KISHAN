import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_widgets.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb4MyOrderScreen extends StatelessWidget with Bnb4MyOrderWidgets, Bnb3HomeWidgets {
  Bnb4MyOrderScreen({super.key});

  final Bnb4MyOrderController controller = Get.find();
  final Bnb3HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: homeController.refreshLocation,
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Top Location Bar Header
              workerHomeHeader(context, homeController),
              sizedboxHeight(14),
              // Body Padding Container
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                child: Obx(() {
                  final bool isUnderReview = homeController.isUnderReview.value;
                  return Column(
                    children: [
                      workerProfileCard(homeController),
                      if (isUnderReview) ...[
                        sizedboxHeight(12),
                        workerStatusActionCard(homeController),
                      ],
                      sizedboxHeight(12),
                      workerKeyStatsGrid(),
                      sizedboxHeight(12),
                      ongoingProjectCard(),
                      sizedboxHeight(16),
                      myVendorRequestedSection(homeController),
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
