import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo_worker/static_dummy_data/static_dummy_data.dart';
import 'package:get/get.dart';

class Bnb3HomeController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final RxList<HomeMaterialModel> materials = <HomeMaterialModel>[].obs;
  final RxList<HomeWorkerModel> workers = <HomeWorkerModel>[].obs;
  final RxList<HomeCategoryModel> categories = <HomeCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    globalController.fetchUserLocation();
    _loadHomeDummyData();
  }

  Future<void> _loadHomeDummyData() async {
    final Map data = await StaticDummyData.getHomeData();
    materials.assignAll(
      apiPeramList(
        data['trendingMaterials'],
      ).map((item) => HomeMaterialModel.fromMap(item)),
    );
    workers.assignAll(
      apiPeramList(
        data['skilledWorkers'],
      ).map((item) => HomeWorkerModel.fromMap(item)),
    );
    categories.assignAll(
      apiPeramList(
        data['materialCategories'],
      ).map((item) => HomeCategoryModel.fromMap(item)),
    );
  }

  final RxBool isUnderReview = false.obs; // Default to false to show Verified screen
  final RxString workerName = "Ravi Kumar".obs;
  final RxString workerRole = "Mason".obs;
  final RxString workerExperience = "4 Years Experience".obs;

  void toggleReviewState() {
    isUnderReview.value = !isUnderReview.value;
  }

  Future<void> refreshLocation() {
    return globalController.fetchUserLocation(refresh: true);
  }
}
