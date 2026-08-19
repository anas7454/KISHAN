import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

class AppNotificationModel {
  AppNotificationModel.fromMap(Map data)
    : id = apiPeramString(data['id']),
      title = apiPeramString(data['title'], initialValue: 'Notification'),
      message = apiPeramString(data['message']),
      createdAt = apiPeramString(data['createdAt']),
      isRead = apiPeramBool(data['isRead']);

  final String id;
  final String title;
  final String message;
  final String createdAt;
  bool isRead;
}
