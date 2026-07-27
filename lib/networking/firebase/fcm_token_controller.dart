import 'dart:async';
import 'dart:io';
import 'package:constructo/networking/api/endpoints/notification_api_services.dart';
import 'package:constructo/networking/extensions/api_helper.dart';
import 'package:constructo/networking/firebase/flutter_local_notification.dart';
import 'package:constructo/networking/user/controllers/user_controller.dart';
import 'package:constructo/utils/common/debug_utils.dart';
import 'package:constructo/utils/device_info_methods.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FcmTokenController extends GetxController {
  StreamSubscription<String>? _fcmTokenRefreshSub;
  bool _isFcmTokenSending = false;
  // String _lastSyncedFcmTokenKey = "";

  @override
  void onInit() {
    super.onInit();
    _listenFcmTokenRefresh();
  }

  Future<void> sendFcmToken({String? fcmToken, bool force = false}) async {
    if (_isFcmTokenSending) return;

    try {
      _isFcmTokenSending = true;
      await FirebaseMessaging.instance.requestPermission();

      final String? resolvedToken = fcmToken ?? await getToken();
      final String token = resolvedToken ?? "";
      if (token.isEmpty) return;

      // final String? userId = Get.find<UserController>().userData.value.userId;
      //  final String syncKey = "${token}_$userId";

      // if (!force && _lastSyncedFcmTokenKey == syncKey) return;

      final Map<String, dynamic> rawData = {
        "fcmToken": token,
        "platform": Platform.isAndroid ? "android" : "ios",
        "deviceId": await deviceIdUniqueGet(),
        "appVersion": await getAppVersion(),
        // "userId": userId,
      };

      final Map res = await NotificationApiServices.sendFcmToken(
        cleanMap(rawData),
      );

      if (res["success"] == true || res["statusCode"] == 200) {
        // _lastSyncedFcmTokenKey = syncKey;
      }
    } catch (e) {
      printDebugCustom("sendFcmToken error -> $e");
    } finally {
      _isFcmTokenSending = false;
    }
  }

  void _listenFcmTokenRefresh() {
    _fcmTokenRefreshSub ??= FirebaseMessaging.instance.onTokenRefresh.listen((
      token,
    ) {
      sendFcmToken(fcmToken: token, force: true);
    });
  }

  @override
  void onClose() {
    _fcmTokenRefreshSub?.cancel();
    super.onClose();
  }
}
