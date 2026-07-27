import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_model.dart';
import 'package:constructo_worker/static_dummy_data/static_dummy_data.dart';
import 'package:get/get.dart';

class Bnb1WorkersController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final RxList<Bnb1WorkerModel> workers = <Bnb1WorkerModel>[].obs;
  final RxString selectedCategory = 'All'.obs;

  List<Bnb1WorkerModel> get filteredWorkers {
    if (selectedCategory.value == 'All') return workers;
    return workers
        .where((worker) => worker.category == selectedCategory.value)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> _loadDummyData() async {
    final Map data = await StaticDummyData.getWorkersData();
    categories.assignAll(apiPeramList(data['categories']).cast<String>());
    workers.assignAll(
      apiPeramList(
        data['workers'],
      ).map((item) => Bnb1WorkerModel.fromMap(apiPeramMap(item))),
    );
  }
}
