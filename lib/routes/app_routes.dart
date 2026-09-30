import 'package:constructo_worker/screens/auth/splash/splash_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/all_services/all_services_screen.dart';
import 'package:constructo_worker/screens/equipment/equipment_list_screen.dart';
import 'package:constructo_worker/screens/equipment/equipment_detail_screen.dart';
import 'package:constructo_worker/screens/equipment/provider_detail_screen.dart';
import 'package:constructo_worker/screens/booking/booking_slot_screen.dart';
import 'package:constructo_worker/screens/booking/booking_summary_screen.dart';
import 'package:constructo_worker/bindings/bottomnavbar_bindings.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/screens/bottomnavbar/bottomnavbar_screen.dart';
import 'package:constructo_worker/screens/wallet/wallet_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static Transition mytransition = Transition.noTransition;
  static Duration transitionDuration = const Duration(milliseconds: 100);

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRouteName.splashScreen,
      page: () => const SplashScreen(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.onboardingScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.loginScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.loginOtpScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.bottomNavBarScreen,
      page: () => const BottomNavBarScreen(),
      binding: BottomnavbarScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.workerRegistrationScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.editProfileScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.workerVerificationStatusScreen,
      page: () => const BottomNavBarScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.walletScreen,
      page: () => const WalletScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.allServicesScreen,
      page: () => const AllServicesScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouteName.equipmentListScreen,
      page: () => const EquipmentListScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouteName.equipmentDetailScreen,
      page: () => const EquipmentDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouteName.providerDetailScreen,
      page: () => const ProviderDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouteName.bookingSlotScreen,
      page: () => const BookingSlotScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRouteName.bookingSummaryScreen,
      page: () => const BookingSummaryScreen(),
      transition: Transition.rightToLeft,
    ),
  ];

  static Future<void> onboardingScreen() async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> loginScreen() async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> loginOtpScreen(String phoneNumber) async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> bottomNavBarScreen() async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> workerRegistrationScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> resumeWorkerRegistrationScreen({
    required int step,
    required String status,
    required int completedSections,
    required int totalSections,
    required List<Map<String, dynamic>> sections,
  }) async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> workerVerificationStatusRootScreen() async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> editProfileScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> notificationsScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> reportIssueScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> aboutAppScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> termsAndConditionsScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> privacyPolicyScreen() async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> requestDetailsScreen({
    String bookingId = '',
    String status = '',
  }) async {
    return Get.toNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<void> walletScreen() async {
    return Get.toNamed(AppRouteName.walletScreen);
  }
}
