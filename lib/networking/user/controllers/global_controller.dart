import 'package:constructo_worker/networking/preferences/user_location_pref.dart';
import 'package:constructo_worker/networking/user/models/user_location_model.dart';
import 'package:constructo_worker/utils/location/user_location_service.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final Rx<UserLocationModel> userLocation = UserLocationModel().obs;
  final RxBool isLocationLoading = false.obs;

  Future<UserLocationModel> fetchUserLocation({bool refresh = false}) async {
    final UserLocationModel saved = await UserLocationPref.read();
    if (saved.isValid) userLocation.value = saved;
    if (!refresh && userLocation.value.isValid) return userLocation.value;

    final String? permissionMessage =
        await UserLocationService.permissionError();
    if (permissionMessage != null) {
      if (!userLocation.value.isValid) {
        userLocation.value = UserLocationModel()
          ..errorMessage = permissionMessage;
      }
      return userLocation.value;
    }

    isLocationLoading.value = true;
    final UserLocationModel current = await UserLocationService.current();
    isLocationLoading.value = false;
    if (current.isValid) await saveUserLocation(current);
    return userLocation.value;
  }

  Future<void> saveUserLocation(UserLocationModel location) async {
    userLocation.value = location;
    await UserLocationPref.save(location);
  }

  Future<void> initGlobal() => fetchUserLocation();

  void resetVarible() {
    userLocation.value = UserLocationModel();
  }
}
