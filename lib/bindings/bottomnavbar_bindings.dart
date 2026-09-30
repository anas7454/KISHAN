import 'package:constructo_worker/screens/bottomnavbar/bottomnavbar_controller.dart';
import 'package:get/get.dart';

class BottomnavbarScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
  }
}
