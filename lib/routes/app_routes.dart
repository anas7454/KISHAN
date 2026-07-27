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
  ];

  static Future<void> onboardingScreen() async {
    return Get.offAllNamed(AppRouteName.onboardingScreen);
  }

  static Future<void> loginScreen() async {
    return Get.offAllNamed(AppRouteName.loginScreen);
  }

  static Future<void> loginOtpScreen(String phoneNumber, Map data) async {
    return Get.toNamed(
      AppRouteName.loginOtpScreen,
      arguments: {Arguments.phoneNumber: phoneNumber, Arguments.data: data},
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
}
