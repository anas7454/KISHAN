import 'package:constructo_worker/networking/api/app_api_services.dart';

class NotificationApiServices {
  static Future<Map> sendFcmToken(Map<String, dynamic> data) async {
    const path = "/v1/notifications/fcm-token";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: data,
    );
  }
}
