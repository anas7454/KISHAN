import 'package:constructo_worker/networking/firebase/fcm_token_controller.dart';
import 'package:constructo_worker/networking/firebase/flutter_local_notification.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:constructo_worker/utils/internet_connectivity_service/app_connectivity_controller.dart';
import 'package:constructo_worker/utils/internet_connectivity_service/app_connectivity_wrapper.dart';
import 'package:constructo_worker/utils/theme/app_theme/app_theme.dart';
import 'package:constructo_worker/utils/theme/app_theme/system_ui_overlaystyle_custom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final systemUiStyle = whiteThemeSystemUI(isTransparentNavigationBarColor: true);
@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  printDebugCustom("backgroundHandler notification call");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // --------------------
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(systemUiStyle);

  // Dependency injection

  await dependencyInjection();

  runApp(MyApp());
}

Future<void> dependencyInjection() async {
  Get.put(UserController(), permanent: true);
  Get.put(GlobalController(), permanent: true);

  final FcmTokenController fcmTokenController = FcmTokenController();
  Get.put(fcmTokenController, permanent: true);

  final AppConnectivityController appConnectivityController =
      AppConnectivityController();
  Get.put(appConnectivityController, permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: rootNavigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Constructo Worker',
          builder: (context, child) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   AppImageCache.precacheAndPinGradientImages(context);
            //   AppImageCache.precacheAndPinAnimationImages(context);
            // });

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemUiStyle,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ), //. mobile font increes pr increse nhi hoga //
                child: AppConnectivityWrapper(
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            );
          },
          theme: AppThemes.lightTheme(context),
          // darkTheme: AppThemes.darkTheme(context),
          // themeMode: controller.selectedThemeMode.value,
          initialRoute: AppRouteName.splashScreen,

          popGesture: true,
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 450),
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
