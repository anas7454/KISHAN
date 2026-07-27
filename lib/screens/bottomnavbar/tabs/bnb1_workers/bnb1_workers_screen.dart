import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb1WorkersScreen extends StatelessWidget with Bnb1WorkersWidgets {
  Bnb1WorkersScreen({super.key});

  final Bnb1WorkersController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // appbar
          workersHeader(),

          // category row
          sizedboxHeight(15),
          workerCategories(controller),
          // list
          sizedboxHeight(15),
          Expanded(child: workersGrid(controller)),
        ],
      ),
    );
  }
}
