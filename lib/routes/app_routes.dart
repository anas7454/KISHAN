import 'package:constructo_worker/bindings/auth_bindings.dart';
import 'package:constructo_worker/bindings/bottomnavbar_bindings.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/routes/arguments.dart';
import 'package:constructo_worker/screens/auth/login/login_screen.dart';
import 'package:constructo_worker/screens/auth/login/otp/login_otp_screen.dart';
import 'package:constructo_worker/screens/auth/onboarding/onboarding_screen.dart';
import 'package:constructo_worker/screens/auth/splash/splash_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/bottomnavbar_screen.dart';
import 'package:constructo_worker/screens/home_location_search/home_location_search_controller.dart';
import 'package:constructo_worker/screens/home_location_search/home_location_search_screen.dart';
import 'package:constructo_worker/networking/user/models/user_location_model.dart';
import 'package:get/get.dart';

import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_screen.dart';

import 'package:constructo_worker/screens/edit_profile/edit_profile_screen.dart';
import 'package:constructo_worker/screens/info_content/info_content_data.dart';
import 'package:constructo_worker/screens/info_content/info_content_screen.dart';
import 'package:constructo_worker/screens/notifications/notifications_screen.dart';
import 'package:constructo_worker/screens/request_details/request_details_screen.dart';
import 'package:constructo_worker/screens/worker_verification_status/worker_verification_status_screen.dart';

class AppRoutes {
  static Transition mytransition =
      Transition.noTransition; // ya Transition.none // Transition.fadeIn
  static Duration transitionDuration = const Duration(milliseconds: 100);
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRouteName.splashScreen,
      page: () => SplashScreen(),
      binding: SplashScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.onboardingScreen,
      page: () => OnboardingScreen(),
      binding: OnboardingScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.loginScreen,
      page: () => LoginScreen(),
      binding: LoginScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.loginOtpScreen,
      page: () => LoginOtpScreen(),
      binding: LoginOtpScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.bottomNavBarScreen,
      page: () => BottomNavBarScreen(),
      binding: BottomnavbarScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.homeLocationSearchScreen,
      page: () => HomeLocationSearchScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => HomeLocationSearchController()),
      ),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.workerRegistrationScreen,
      page: () => WorkerRegistrationScreen(),
      binding: WorkerRegistrationScreenBindings(),
      participatesInRootNavigator: true,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.editProfileScreen,
      page: () => EditProfileScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.infoContentScreen,
      page: () {
        final Map<String, dynamic> args =
            Get.arguments as Map<String, dynamic>? ?? {};
        return InfoContentScreen(
          title: args['title'] as String? ?? '',
          sections: (args['sections'] as List?)?.cast() ?? [],
        );
      },
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.requestDetailsScreen,
      page: () => RequestDetailsScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
    GetPage(
      name: AppRouteName.workerVerificationStatusScreen,
      page: () => WorkerVerificationStatusScreen(),
      participatesInRootNavigator: false,
      transition: mytransition,
      transitionDuration: transitionDuration,
    ),
  ];

  static Future<void> onboardingScreen() async {
    return Get.offAllNamed(AppRouteName.onboardingScreen);
  }

  static Future<void> loginScreen() async {
    return Get.offAllNamed(AppRouteName.loginScreen);
  }

  static Future<void> loginOtpScreen(String phoneNumber) async {
    return Get.toNamed(
      AppRouteName.loginOtpScreen,
      arguments: {Arguments.phoneNumber: phoneNumber},
    );
  }

  static Future<void> bottomNavBarScreen() async {
    return Get.offAllNamed(AppRouteName.bottomNavBarScreen);
  }

  static Future<UserLocationModel?> homeLocationSearchScreen() async {
    final dynamic result = await Get.toNamed(
      AppRouteName.homeLocationSearchScreen,
    );
    return result is UserLocationModel ? result : null;
  }

  static Future<void> workerRegistrationScreen() async {
    return Get.toNamed(AppRouteName.workerRegistrationScreen);
  }

  static Future<void> resumeWorkerRegistrationScreen({
    required int step,
    required String status,
    required int completedSections,
    required int totalSections,
    required List<Map<String, dynamic>> sections,
  }) async {
    return Get.offAllNamed(
      AppRouteName.workerRegistrationScreen,
      arguments: <String, dynamic>{
        'initialStep': step,
        'kycStatus': status,
        'completedSections': completedSections,
        'totalSections': totalSections,
        'kycSections': sections,
      },
    );
  }

  static Future<void> workerRegistrationPreviewScreen(int step) async {
    return Get.toNamed(
      AppRouteName.workerRegistrationScreen,
      arguments: <String, dynamic>{'previewMode': true, 'previewStep': step},
    );
  }

  static Future<void> workerVerificationStatusScreen({
    bool documentsView = false,
  }) async {
    return Get.toNamed(
      AppRouteName.workerVerificationStatusScreen,
      arguments: <String, dynamic>{'documentsView': documentsView},
    );
  }

  static Future<void> workerVerificationStatusRootScreen() async {
    return Get.offAllNamed(AppRouteName.workerVerificationStatusScreen);
  }

  static Future<void> editProfileScreen() async {
    return Get.to<void>(
      () => EditProfileScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  static Future<void> notificationsScreen() async {
    return Get.to<void>(
      () => const NotificationsScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  static Future<void> aboutAppScreen() async {
    return Get.to<void>(
      () => InfoContentScreen(
        title: 'About App',
        sections: InfoContentData.aboutApp,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  static Future<void> termsAndConditionsScreen() async {
    return Get.to<void>(
      () => InfoContentScreen(
        title: 'Terms & Conditions',
        sections: InfoContentData.termsAndConditions,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  static Future<void> privacyPolicyScreen() async {
    return Get.to<void>(
      () => InfoContentScreen(
        title: 'Privacy Policy',
        sections: InfoContentData.privacyPolicy,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  static Future<void> requestDetailsScreen({
    String bookingId = '',
    String status = '',
  }) async {
    return Get.toNamed(
      AppRouteName.requestDetailsScreen,
      arguments: <String, dynamic>{Arguments.id: bookingId, 'status': status},
    );
  }
}
