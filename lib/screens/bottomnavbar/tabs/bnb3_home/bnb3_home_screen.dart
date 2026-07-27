import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_widgets.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/widgets/material_categories_widget.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/widgets/skilled_workers_widget.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/widgets/trending_materials_widget.dart';
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
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.refreshLocation,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              homeHeader(context, controller),

              // strat from banner
              Obx(
                () => Container(
                  width: getWidth(),

                  padding: EdgeInsets.only(left: 12.rw),
                  child: Column(
                    children: [
                      sizedboxHeight(15),
                      Container(
                        margin: EdgeInsets.only(right: 12.rw),
                        child: offerBanner(),
                      ),
                      SizedBox(height: 18.rh),
                      TrendingMaterialsWidget.content(controller),
                      sizedboxHeight(8),
                      SkilledWorkersWidget.content(controller),

                      sizedboxHeight(8),
                      MaterialCategoriesWidget.content(controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
