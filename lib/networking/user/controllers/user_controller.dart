import 'package:constructo_worker/networking/preferences/user_data_pref.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/networking/user/models/user_model.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<UserModel> userData = UserModel().obs;

  /// ------ Check if user is logged in --------

  bool get isLoggedIn => userData.value.jwtToken.isNotEmpty;
  bool get isNotLoggedIn => !isLoggedIn;

  // @override
  // void onReady() {
  //   super.onReady();
  //   alreadyLoginCheck();
  // }

  Future<void> alreadyLoginCheck() async {
    userData.value = await UserDataPref.getUserData();

    // check jwt expired or not
    final tokenExpired = UserDataPref.isJwtExpired(userData.value.jwtToken);
    printDebugCustom(
      "splash screen alreadyLoginCheck --> isLoggedIn -->$isLoggedIn  tokenExpired -->$tokenExpired ,  loginedin-->${isLoggedIn && !tokenExpired}",
    );
    if (isLoggedIn && !tokenExpired) {
      AppRoutes.bottomNavBarScreen();
    } else {
      AppRoutes.onboardingScreen();
    }
  }

  Future<void> setLoginData(Map data) async {
    await UserDataPref.setUserData(data);
    userData.value = await UserDataPref.getUserData();
  }

  // --------------------------- guest login --------------------------------
  void guestLogin() async {
    await _resetUserSessionData();
    // printDebugCustom("guest login jwtToken -->${jwtToken.value}");
    AppRoutes.bottomNavBarScreen();
  }
  // --------------------------- logout --------------------------------

  Future<void> logout({
    String showToastMsg = 'Logout!',
    bool isApiCall = false,
  }) async {
    if (isApiCall) {
      // await NetworkCalls.updateFcmToken({"fcmToken": ''});
    }

    await _resetUserSessionData();

    if (showToastMsg.isNotEmpty) {
      showToastSuccess(showToastMsg);
    }

    // AppRoutes.loginScreen(offAll: true);

    AppRoutes.loginScreen();
  }

  Future<void> _resetUserSessionData() async {
    try {
      await UserDataPref.clearUserData();

      userData.value = UserModel();
      final GlobalController globalController = Get.find();
      globalController.resetVarible();
      // final ProfileAndKycUpdateController profileController = Get.find();
      // profileController.resetVarible();
    } catch (e) {
      printDebugCustom("resetUserSessionData Errro -->$e");
    }
  }
}
