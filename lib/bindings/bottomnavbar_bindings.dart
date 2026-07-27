import 'package:constructo/screens/bottomnavbar/bottomnavbar_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_controller.dart';
import 'package:get/get.dart';

class BottomnavbarScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomnavbarController());
    Get.lazyPut(() => Bnb1WorkersController());
    Get.lazyPut(() => Bnb2MaterialController());
    Get.lazyPut(() => Bnb3HomeController());
    Get.lazyPut(() => Bnb4MyOrderController());
    Get.lazyPut(() => Bnb5MyProfileController());
  }
}
