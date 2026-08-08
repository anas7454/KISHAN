import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:get/get.dart';

class WorkerVerificationStatusController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  final RxString workerName = "Ravi Kumar".obs;
  final RxString workerRole = "Mason".obs;
  final RxString workerExperience = "4 Years Experience".obs;
  final RxBool isUnderReview = true.obs;

  Future<void> refreshStatus() async {
    await globalController.fetchUserLocation(refresh: true);
  }
}
