import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RequestsScreenMode { requests, myWork }

class Bnb2MaterialScreen extends StatelessWidget with Bnb2MaterialWidgets {
  final RequestsScreenMode mode;

  Bnb2MaterialScreen({
    super.key,
    this.mode = RequestsScreenMode.requests,
  });

  Bnb2MaterialController get controller {
    final tag = mode == RequestsScreenMode.requests ? 'requests' : 'myWork';
    if (!Get.isRegistered<Bnb2MaterialController>(tag: tag)) {
      final c = Get.put(Bnb2MaterialController(), tag: tag);
      // Set initial filter based on mode
      if (mode == RequestsScreenMode.requests) {
        c.changeFilter(RequestFilterTab.newReq);
      } else {
        c.changeFilter(RequestFilterTab.accepted);
      }
      return c;
    }
    return Get.find<Bnb2MaterialController>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final title = mode == RequestsScreenMode.requests ? 'Requests' : 'My Work';
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            // Top Location Header
            requestsHeader(context, ctrl, title: title),
            sizedboxHeight(14),
            // Body Container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.rw),
              child: Column(
                children: [
                  // My Work tab gets filter pills (Accepted / Rejected)
                  if (mode == RequestsScreenMode.myWork) ...([
                    filterTabsRow(ctrl, showAll: false),
                    sizedboxHeight(14),
                  ]),
                  // Cards List
                  requestsList(ctrl),
                  sizedboxHeight(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
