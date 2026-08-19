import 'package:constructo_worker/networking/api/app_api_services.dart';
import 'package:constructo_worker/models/app_notification_model.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

class NotificationApiServices {
  static const String _path = '/api/notifications';
  static Future<Map> sendFcmToken(Map<String, dynamic> data) async {
    const path = "/v1/notifications/fcm-token";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: data,
    );
  }

  static Future<List<AppNotificationModel>> getNotifications() async {
    final Map response = await AppApiServices.apiRequest(_path);
    if (!apiResponseSuccess(response)) return <AppNotificationModel>[];
    final dynamic data = response['data'];
    final List items = data is List
        ? data
        : apiPeramList(data is Map ? data['notifications'] : null);
    return items
        .whereType<Map>()
        .map((item) => AppNotificationModel.fromMap(item))
        .toList();
  }

  static Future<int> getUnreadCount() async {
    final Map response = await AppApiServices.apiRequest('$_path/unread-count');
    if (!apiResponseSuccess(response)) return 0;
    final dynamic data = response['data'];
    return data is Map
        ? apiPeramInt(data['unreadCount'] ?? data['count'])
        : apiPeramInt(data);
  }

  static Future<Map> markAllRead() => AppApiServices.apiRequest(
    '$_path/mark-all-read',
    apiType: EnumApiType.put,
  );

  static Future<Map> markRead(String id) =>
      AppApiServices.apiRequest('$_path/$id/read', apiType: EnumApiType.put);

  static Future<Map> deleteNotification(String id) =>
      AppApiServices.apiRequest('$_path/$id', apiType: EnumApiType.delete);
}
