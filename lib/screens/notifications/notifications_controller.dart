import 'package:constructo_worker/models/app_notification_model.dart';
import 'package:constructo_worker/networking/api/endpoints/notification_api_services.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final notifications = <AppNotificationModel>[].obs;
  final unreadCount = 0.obs;
  final isLoading = false.obs;
  final processingIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    refreshPage();
  }

  Future<void> refreshPage() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final results = await Future.wait<dynamic>([
        NotificationApiServices.getNotifications(),
        NotificationApiServices.getUnreadCount(),
      ]);
      notifications.assignAll(results[0] as List<AppNotificationModel>);
      unreadCount.value = results[1] as int;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAllRead() async {
    if (unreadCount.value == 0) return;
    final response = await NotificationApiServices.markAllRead();
    if (!apiResponseSuccess(response)) return showToastError(response);
    for (var i = 0; i < notifications.length; i++) {
      notifications[i].isRead = true;
      notifications[i] = notifications[i];
    }
    unreadCount.value = 0;
  }

  Future<void> markRead(AppNotificationModel item) async {
    if (item.isRead || processingIds.contains(item.id)) return;
    processingIds.add(item.id);
    final response = await NotificationApiServices.markRead(item.id);
    processingIds.remove(item.id);
    if (!apiResponseSuccess(response)) return showToastError(response);
    item.isRead = true;
    final index = notifications.indexWhere((value) => value.id == item.id);
    if (index >= 0) notifications[index] = item;
    if (unreadCount.value > 0) unreadCount.value--;
  }

  Future<void> deleteNotification(AppNotificationModel item) async {
    if (processingIds.contains(item.id)) return;
    processingIds.add(item.id);
    final response = await NotificationApiServices.deleteNotification(item.id);
    processingIds.remove(item.id);
    if (!apiResponseSuccess(response)) return showToastError(response);
    notifications.removeWhere((value) => value.id == item.id);
    if (!item.isRead && unreadCount.value > 0) unreadCount.value--;
  }
}
