import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:constructo_worker/static_dummy_data/static_dummy_data.dart';
import 'package:get/get.dart';

class Bnb3HomeController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final RxList<HomeMaterialModel> materials = <HomeMaterialModel>[].obs;
  final RxList<HomeWorkerModel> workers = <HomeWorkerModel>[].obs;
  final RxList<HomeCategoryModel> categories = <HomeCategoryModel>[].obs;
  final RxList<WorkerBookingModel> pendingBookings = <WorkerBookingModel>[].obs;
  final RxBool isBookingsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    globalController.fetchUserLocation();
    _loadHomeDummyData();
    getPendingBookings();
  }

  Future<void> getPendingBookings() async {
    if (isBookingsLoading.value) return;
    isBookingsLoading.value = true;
    final Map response = await WorkerBookingApiServices.getPendingBookings();
    isBookingsLoading.value = false;
    if (!apiResponseSuccess(response)) return;

    final dynamic responseData = response['data'];
    final List bookings = responseData is List
        ? responseData
        : apiPeramList(
            responseData is Map
                ? responseData['bookings'] ??
                    responseData['pendingBookings'] ??
                    responseData['items'] ??
                    responseData['results'] ??
                    responseData['data']
                : null,
          );
    pendingBookings.assignAll(
      bookings.whereType<Map>().map(WorkerBookingModel.fromMap),
    );
  }

  Future<void> acceptBooking(WorkerBookingModel booking) async {
    final Map response = await WorkerBookingApiServices.acceptBooking(booking.id);
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    pendingBookings.removeWhere((item) => item.id == booking.id);
    Get.snackbar('Request Accepted', 'You accepted ${booking.title} request');
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

  Future<void> refreshLocation() async {
    await Future.wait<void>([
      globalController.fetchUserLocation(refresh: true),
      getPendingBookings(),
    ]);
  }
}
