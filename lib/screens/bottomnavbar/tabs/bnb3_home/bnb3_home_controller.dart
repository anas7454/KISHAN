import 'dart:async';

import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/worker_profile_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/worker_kyc_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:constructo_worker/static_dummy_data/static_dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb3HomeController extends GetxController with WidgetsBindingObserver {
  final GlobalController globalController = Get.find<GlobalController>();
  final RxList<HomeMaterialModel> materials = <HomeMaterialModel>[].obs;
  final RxList<HomeWorkerModel> workers = <HomeWorkerModel>[].obs;
  final RxList<HomeCategoryModel> categories = <HomeCategoryModel>[].obs;
  final RxList<WorkerBookingModel> pendingBookings = <WorkerBookingModel>[].obs;
  final RxBool isBookingsLoading = false.obs;
  final RxString processingBookingId = ''.obs;
  final RxString processingAction = ''.obs;
  Timer? _pendingBookingsPollingTimer;
  bool _pendingBookingsInFlight = false;

  @override
  void onInit() {
    super.onInit();
    WorkerBookingApiServices.addProcessedListener(_removeProcessedBooking);
    WidgetsBinding.instance.addObserver(this);
    globalController.fetchUserLocation();
    _loadHomeDummyData();
    getWorkerProfile();
    getKycVerificationStatus();
    getPendingBookings();
    _startPendingBookingsPolling();
    getOngoingBooking();
  }

  void _startPendingBookingsPolling() {
    _pendingBookingsPollingTimer?.cancel();
    _pendingBookingsPollingTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => getPendingBookings(showLoading: false),
    );
  }

  @override
  void onReady() {
    super.onReady();
    _startPendingBookingsPolling();
    getPendingBookings(showLoading: false);
  }

  @override
  void onClose() {
    WorkerBookingApiServices.removeProcessedListener(_removeProcessedBooking);
    WidgetsBinding.instance.removeObserver(this);
    _pendingBookingsPollingTimer?.cancel();
    super.onClose();
  }

  void _removeProcessedBooking(String bookingId) {
    pendingBookings.removeWhere((booking) => booking.id == bookingId);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPendingBookingsPolling();
      getPendingBookings(showLoading: false);
    }
  }

  Future<void> getKycVerificationStatus() async {
    final Map response = await WorkerKycApiServices.getWorkerKycStatus();
    if (!apiResponseSuccess(response)) return;
    final Map data = apiPeramMap(response['data']);
    final String status = apiPeramString(data['status']).toUpperCase();
    isKycApproved.value = status == 'APPROVED';
    isUnderReview.value = status != 'APPROVED';
  }

  Future<void> getOngoingBooking() async {
    final Map response = await WorkerBookingApiServices.getWorkerHistory(
      'ACCEPTED',
    );
    if (!apiResponseSuccess(response)) return;
    final dynamic responseData = response['data'];
    final List bookings = responseData is List
        ? responseData
        : apiPeramList(
            responseData is Map
                ? responseData['bookings'] ??
                      responseData['history'] ??
                      responseData['items'] ??
                      responseData['results'] ??
                      responseData['data']
                : null,
          );
    final List<WorkerBookingModel> accepted = bookings
        .whereType<Map>()
        .map(WorkerBookingModel.fromMap)
        .toList();
    ongoingBooking.value = accepted.firstOrNull;
  }

  Future<void> getWorkerProfile() async {
    final Map response = await WorkerProfileApiServices.getProfile();
    if (!apiResponseSuccess(response)) return;

    final Map rawResponseData = apiPeramMap(response['data']);
    final Map responseData = rawResponseData.isEmpty
        ? response
        : rawResponseData;
    final Map nestedProfile = apiPeramMap(
      responseData['worker'] ??
          responseData['workerProfile'] ??
          responseData['profile'] ??
          responseData['user'],
    );
    final Map data = nestedProfile.isEmpty ? responseData : nestedProfile;
    final Map personalInfo = apiPeramMap(data['personalInfo']);
    final Map skill = apiPeramMap(data['skill']);
    final List skills = apiPeramList(data['skills']);
    final Map firstSkill = skills.isNotEmpty && skills.first is Map
        ? apiPeramMap(skills.first)
        : <String, dynamic>{};

    final String firstName = apiPeramString(data['firstName']);
    final String lastName = apiPeramString(data['lastName']);
    workerName.value = apiPeramString(
      data['name'] ??
          data['fullName'] ??
          data['workerName'] ??
          personalInfo['fullName'],
      initialValue: '$firstName $lastName'.trim(),
    );
    workerRole.value = apiPeramString(
      data['skillCategory'] ??
          data['skillName'] ??
          skill['name'] ??
          firstSkill['name'],
      initialValue: workerRole.value,
    );
    final String experience = apiPeramString(
      data['experienceYears'] ?? data['experience'],
    );
    if (experience.isNotEmpty) {
      workerExperience.value = '$experience Years Experience';
    }
    workerProfileImage.value = apiPeramString(
      data['profileImage'] ?? data['selfieImage'],
    );
    workerIsAvailable.value = apiPeramBool(data['isAvailable']);
    workerRating.value = apiPeramDouble(data['rating']);
    workerTotalReviews.value = apiPeramInt(data['totalReviews']);
    workerDailyWage.value = apiPeramDouble(
      data['dailyWage'] ?? data['hourlyRate'],
    );
    workerRadiusKm.value = apiPeramDouble(data['radiusKm']);
    workerCompletedJobs.value = apiPeramInt(
      data['completedJobs'] ??
          data['jobsCompleted'] ??
          data['totalCompletedJobs'] ??
          data['completedBookings'],
    );
    workerTotalEarnings.value = apiPeramDouble(
      data['totalEarnings'] ?? data['earnings'] ?? data['earnedAmount'],
    );
  }

  Future<void> getPendingBookings({bool showLoading = true}) async {
    if (_pendingBookingsInFlight) return;
    _pendingBookingsInFlight = true;
    if (showLoading) isBookingsLoading.value = true;
    final Map response = await WorkerBookingApiServices.getPendingBookings();
    _pendingBookingsInFlight = false;
    if (showLoading) isBookingsLoading.value = false;
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
    final Set<String> previousIds = pendingBookings
        .map((booking) => booking.id)
        .toSet();
    final List<WorkerBookingModel> latestBookings = bookings
        .whereType<Map>()
        .map(WorkerBookingModel.fromMap)
        .where(
          (booking) =>
              !WorkerBookingApiServices.acceptedBookingIds.contains(
                booking.id,
              ) &&
              !WorkerBookingApiServices.rejectedBookingIds.contains(booking.id),
        )
        .toList();
    pendingBookings.assignAll(latestBookings);
    pendingBookings.refresh();
    debugPrint('[REQUEST_POLL] Home received=${pendingBookings.length}');

    final WorkerBookingModel? newBooking = latestBookings
        .where((booking) => !previousIds.contains(booking.id))
        .firstOrNull;
    if (newBooking != null && Get.context != null) {
      Get.snackbar(
        'New Work Request',
        '${newBooking.title} • ${newBooking.displayRequestedOn}',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 6),
        backgroundColor: const Color(0xff16A34A),
        colorText: Colors.white,
        icon: const Icon(
          Icons.notifications_active_rounded,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        mainButton: TextButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
            AppRoutes.requestDetailsScreen(
              bookingId: newBooking.id,
              status: 'PENDING',
            );
          },
          child: const Text(
            'View',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }

  Future<void> acceptBooking(WorkerBookingModel booking) async {
    if (processingBookingId.value.isNotEmpty) return;
    processingBookingId.value = booking.id;
    processingAction.value = 'accept';
    final Map response;
    try {
      response = await WorkerBookingApiServices.acceptBooking(booking.id);
    } finally {
      processingBookingId.value = '';
      processingAction.value = '';
    }
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markAccepted(booking.id);
    pendingBookings.removeWhere((item) => item.id == booking.id);
    if (Get.isRegistered<Bnb2MaterialController>(tag: 'requests')) {
      Get.find<Bnb2MaterialController>(
        tag: 'requests',
      ).removePendingBooking(booking.id);
    }
    await getOngoingBooking();
    Get.snackbar('Request Accepted', 'You accepted ${booking.title} request');
  }

  Future<void> rejectBooking(WorkerBookingModel booking) async {
    if (processingBookingId.value.isNotEmpty) return;
    processingBookingId.value = booking.id;
    processingAction.value = 'reject';
    final Map response;
    try {
      response = await WorkerBookingApiServices.rejectBooking(booking.id);
    } finally {
      processingBookingId.value = '';
      processingAction.value = '';
    }
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markRejected(booking.id);
    pendingBookings.removeWhere((item) => item.id == booking.id);
    if (Get.isRegistered<Bnb2MaterialController>(tag: 'requests')) {
      Get.find<Bnb2MaterialController>(
        tag: 'requests',
      ).removePendingBooking(booking.id);
    }
    Get.snackbar('Request Rejected', 'You rejected ${booking.title} request');
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

  final RxBool isUnderReview = true.obs;
  final RxBool isKycApproved = false.obs;
  final Rxn<WorkerBookingModel> ongoingBooking = Rxn<WorkerBookingModel>();
  final RxString workerName = ''.obs;
  final RxString workerRole = ''.obs;
  final RxString workerExperience = ''.obs;
  final RxString workerProfileImage = ''.obs;
  final RxBool workerIsAvailable = false.obs;
  final RxDouble workerRating = 0.0.obs;
  final RxInt workerTotalReviews = 0.obs;
  final RxDouble workerDailyWage = 0.0.obs;
  final RxDouble workerRadiusKm = 0.0.obs;
  final RxInt workerCompletedJobs = 0.obs;
  final RxDouble workerTotalEarnings = 0.0.obs;

  Future<void> refreshLocation() async {
    await Future.wait<void>([
      globalController.fetchUserLocation(refresh: true),
      getWorkerProfile(),
      getKycVerificationStatus(),
      getPendingBookings(),
      getOngoingBooking(),
    ]);
  }
}
