import 'package:constructo_worker/screens/request_details/request_details_controller.dart';
import 'package:constructo_worker/screens/request_details/request_details_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestDetailsScreen extends StatelessWidget with RequestDetailsWidgets {
  RequestDetailsScreen({super.key});

  final RequestDetailsController controller = Get.put(RequestDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      bottomNavigationBar: stickyBottomActionBar(controller),
      body: Column(
        children: [
          // Fixed Top Yellow Header
          requestDetailsHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedboxHeight(14),
                  // Body Padding Container
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.rw),
                    child: Column(
                      children: [
                        // Card 1: Request Header Card
                        requestHeaderCard(controller),
                        sizedboxHeight(12),
                        // Card 2: Customer Info Card
                        customerInfoCard(controller),
                        sizedboxHeight(12),
                        // Card 3: Work Details Card
                        workDetailsCard(controller),
                        sizedboxHeight(12),
                        // Card 4: Order Summary Card
                        orderSummaryCard(controller),
                        sizedboxHeight(12),
                        // Disclaimer Note Container
                        disclaimerNoteContainer(),
                        sizedboxHeight(24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
