import 'package:get/get.dart';
import 'package:constructo_worker/networking/preferences/user_data_pref.dart';
import 'package:constructo_worker/networking/api/endpoints/worker_profile_api_services.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';

class Bnb5MyProfileController extends GetxController {
  final RxBool isFaceIdEnabled = false.obs;
  final GlobalController globalController = Get.find();
  final UserController userController = Get.find();
  final RxString profileName = ''.obs;
  final RxString profileEmail = ''.obs;
  final RxString profilePhone = ''.obs;
  final RxString profileImage = ''.obs;
  final RxString profileSkill = ''.obs;
  final RxInt profileExperience = 0.obs;
  final RxDouble profileRating = 0.0.obs;
  final RxInt profileTotalReviews = 0.obs;
  final RxBool profileIsAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final Map response = await WorkerProfileApiServices.getProfile();
    if (!apiResponseSuccess(response)) return;
    final Map responseData = apiPeramMap(response['data']);
    final Map worker = apiPeramMap(
      responseData['worker'] ?? responseData['profile'] ?? responseData['user'],
    );
    final Map data = worker.isEmpty ? responseData : worker;
    final String firstName = apiPeramString(data['firstName']);
    final String lastName = apiPeramString(data['lastName']);
    profileName.value = apiPeramString(
      data['fullName'] ?? data['name'],
      initialValue: '$firstName $lastName'.trim(),
    );
    profileEmail.value = apiPeramString(data['email']);
    profilePhone.value = apiPeramString(data['phone'] ?? data['mobile']);
    profileImage.value = apiPeramString(
      data['profileImage'] ??
          data['selfieImage'] ??
          data['profilePhoto'] ??
          data['avatar'],
    );
    final Map skill = apiPeramMap(data['skill']);
    final List skills = apiPeramList(data['skills']);
    final Map firstSkill = skills.isNotEmpty && skills.first is Map
        ? apiPeramMap(skills.first)
        : <String, dynamic>{};
    profileSkill.value = apiPeramString(
      data['skillCategory'] ?? skill['name'] ?? firstSkill['name'],
    );
    profileExperience.value = apiPeramInt(
      data['experienceYears'] ?? data['experience'],
    );
    profileRating.value = apiPeramDouble(data['rating']);
    profileTotalReviews.value = apiPeramInt(data['totalReviews']);
    profileIsAvailable.value = apiPeramBool(data['isAvailable']);
  }

  Future<void> refreshData() async {
    final userDataFuture = UserDataPref.getUserData();
    await Future.wait([
      userDataFuture,
      globalController.fetchUserLocation(refresh: true),
      loadProfile(),
    ]);
    userController.userData.value = await userDataFuture;
  }

  void toggleFaceId(bool value) {
    isFaceIdEnabled.value = value;
  }
}
